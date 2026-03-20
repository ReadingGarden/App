import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../api/AuthAPI.dart';
import '../provider/FcmTokenProvider.dart';

class SocialLogin {
  static Future<void> googleLogin(WidgetRef ref, BuildContext context) async {
    final authAPI = AuthAPI(ref);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;
      if (user != null) {
        print('User UID: ${user.uid}');
        print('User Email: ${user.email}');

        final fcmToken = await ref.read(fcmTokenProvider.future);

        final data = {
          "user_email": user.email,
          "user_password": "",
          "user_fcm": fcmToken ?? '',
          "user_social_id": user.uid,
          "user_social_type": "google"
        };
        authAPI.postSocialLogin(context, data);
      }
    } catch (e) {
      print('Error during Google Sign-In: $e');
    }
  }

  static Future<void> kakaoLogin(WidgetRef ref, BuildContext context) async {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공 ${token.accessToken}');

        _getKakaoUser(ref, context);
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }

        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
          _getKakaoUser(ref, context);
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
        _getKakaoUser(ref, context);
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  static void _getKakaoUser(WidgetRef ref, BuildContext context) async {
    final authAPI = AuthAPI(ref);

    try {
      final user = await UserApi.instance.me();

      print('사용자 정보 요청 성공'
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
      authAPI.postSocialLogin(context, data);
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }
}
