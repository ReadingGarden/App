import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../core/api/AuthAPI.dart';
import '../core/provider/FcmTokenProvider.dart';

class SocialLogin {
  //MARK: - GOOGLE
  static Future<void> googleLogin(WidgetRef ref, BuildContext context) async {
    final authAPI = AuthAPI(ref);
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Retrieve the User details
      final user = userCredential.user;
      if (user != null) {
        // User is successfully signed in
        print('User UID: ${user.uid}');
        print('User Email: ${user.email}');

        // FCM 토큰을 비동기적으로 가져오기
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

  //MARK: - KAKAO
  //카카오 로그인
  static Future<void> kakaoLogin(WidgetRef ref, BuildContext context) async {
    //카카오톡 실행 가능 여부 확인
    // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공 ${token.accessToken}');

        _getKakaoUser(ref, context);
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
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

      // FCM 토큰을 비동기적으로 가져오기
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
