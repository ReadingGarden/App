import 'package:dio/dio.dart';

import '../Utils/SharedPreferences.dart';
import '../utils/Constant.dart';

class OnboardingService {
  final Dio _dio = Dio();

  // 로그인f
  Future<Response?> postLogin(Map data) async {
    try {
      final response = await _dio.post('${Constant.URL}auth/login', data: data);
      print(response.data.toString());
      // refresh 토큰 저장
      // await saveRefresh(response.data['data']['refresh_token']);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        // 서버가 응답한 경우 (상태 코드와 함께)
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        // 서버가 응답하지 않은 경우
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  // 회원가입
  Future<Response?> postSignup(Map data) async {
    try {
      final response = await _dio.post('${Constant.URL}auth/', data: data);
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        // 서버가 응답한 경우 (상태 코드와 함께)
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        // 서버가 응답하지 않은 경우
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  // 비밀번호 찾기 (인증 번호 전송)
  Future<Response?> postPwdFind(Map data) async {
    try {
      final response =
          await _dio.post('${Constant.URL}auth/find-password', data: data);
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        // 서버가 응답한 경우 (상태 코드와 함께)
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        // 서버가 응답하지 않은 경우
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  // 비밀번호 인증 확인
  Future<Response?> postPwdFindCheck(Map data) async {
    try {
      final response = await _dio
          .post('${Constant.URL}auth/find-password/check', data: data);
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        // 서버가 응답한 경우 (상태 코드와 함께)
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        // 서버가 응답하지 않은 경우
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  // 비밀번호 설정하기 (no token)
  Future<Response?> putPwdUpdate(Map data) async {
    try {
      final response = await _dio.post(
          '${Constant.URL}auth/find-password/update-password',
          data: data);
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        // 서버가 응답한 경우 (상태 코드와 함께)
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        // 서버가 응답하지 않은 경우
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }
}
