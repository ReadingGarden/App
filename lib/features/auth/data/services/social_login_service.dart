import 'dart:convert';
import 'dart:math';

import 'package:book_flutter/core/logger.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:book_flutter/features/auth/presentation/providers/auth_user_provider.dart'
    as auth_feature;
import 'package:book_flutter/features/notification/data/fcm_token_provider.dart';

class SocialLogin {
  /// 모든 소셜 로그인 세션 해제 (로그아웃/탈퇴 시 호출)
  static Future<void> signOutAll() async {
    try {
      await GoogleSignIn().signOut();
    } catch (_) {}
    try {
      await UserApi.instance.logout();
    } catch (_) {}
    try {
      await FirebaseAuth.instance.signOut();
    } catch (_) {}
  }

  static Future<void> googleLogin(WidgetRef ref, BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // 사용자가 취소

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;
      if (user != null) {
        logger.i('구글 로그인 성공 사용자 UID: ${user.uid}');
        logger.i('구글 로그인 사용자 이메일: ${user.email}');

        final fcmToken = await ref.read(fcmTokenProvider.future);

        final data = {
          "user_email": user.email,
          "user_password": "",
          "user_fcm": fcmToken ?? '',
          "user_social_id": user.uid,
          "user_social_type": "google"
        };
        if (!context.mounted) return;
        auth_feature.socialLogin(ref, context, data);
      }
    } catch (e) {
      logger.e('구글 로그인 중 오류가 발생했습니다: $e');
    }
  }

  static Future<void> kakaoLogin(WidgetRef ref, BuildContext context) async {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        logger.i('카카오톡 로그인 성공 액세스 토큰: ${token.accessToken}');

        if (!context.mounted) return;
        _getKakaoUser(ref, context);
      } catch (error) {
        logger.e('카카오톡 로그인 실패: $error');

        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }

        try {
          await UserApi.instance.loginWithKakaoAccount();
          logger.i('카카오계정 로그인 성공');
          if (!context.mounted) return;
          _getKakaoUser(ref, context);
        } catch (error) {
          logger.e('카카오계정 로그인 실패: $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        logger.i('카카오계정 로그인 성공');
        if (!context.mounted) return;
        _getKakaoUser(ref, context);
      } catch (error) {
        logger.e('카카오계정 로그인 실패: $error');
      }
    }
  }

  static Future<void> appleLogin(WidgetRef ref, BuildContext context) async {
    try {
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      final user = userCredential.user;

      if (user != null) {
        logger.i('애플 로그인 성공 사용자 UID: ${user.uid}');
        logger.i('애플 로그인 사용자 이메일: ${user.email}');

        final fcmToken = await ref.read(fcmTokenProvider.future);

        final data = {
          "user_email": user.email ?? appleCredential.email ?? '',
          "user_password": "",
          "user_fcm": fcmToken ?? '',
          "user_social_id": user.uid,
          "user_social_type": "apple"
        };
        if (!context.mounted) return;
        auth_feature.socialLogin(ref, context, data);
      }
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) return;
      logger.e('애플 로그인 실패: ${e.code} - ${e.message}');
    } catch (e) {
      logger.e('애플 로그인 중 오류가 발생했습니다: $e');
    }
  }

  static String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  static String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    return sha256.convert(bytes).toString();
  }

  static void _getKakaoUser(WidgetRef ref, BuildContext context) async {
    try {
      final user = await UserApi.instance.me();

      logger.i('카카오 사용자 정보 조회 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');

      final fcmToken = await ref.read(fcmTokenProvider.future);

      final data = {
        "user_email": user.kakaoAccount?.email,
        "user_password": "",
        "user_fcm": fcmToken ?? '',
        "user_social_id": user.id.toString(),
        "user_social_type": "kakao"
      };
      if (!context.mounted) return;
      auth_feature.socialLogin(ref, context, data);
    } catch (error) {
      logger.e('카카오 사용자 정보 조회 실패: $error');
    }
  }
}
