import 'dart:core';

import 'package:book_flutter/core/DioClient.dart';
import 'package:dio/dio.dart';

import '../../utils/Constant.dart';
import '../../utils/SharedPreferences.dart';

class AuthService {
  final _dio = dioclent.dio;
  final _authenticatedDio = dioclent.authenticatedDio;

  // 로그인
  Future<Response?> postLogin(Map data) async {
    final Dio _dio = Dio();

    try {
      final response = await _dio.post('${Constant.URL}auth/login', data: data);
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

  // 로그아웃
  Future<Response?> postLogout() async {
    final accessToken = await loadAccess();
    try {
      final response = await _authenticatedDio.post(
          '${Constant.URL}auth/logout',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
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

  // 회원 탈퇴
  Future<Response?> deleteUser() async {
    final accessToken = await loadAccess();
    try {
      final response = await _authenticatedDio.delete('${Constant.URL}auth/',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
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
      final response = await _dio
          .put('${Constant.URL}auth/find-password/update-password', data: data);
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

  // 유저 정보 조회
  Future<Response?> getUser() async {
    final accessToken = await loadAccess();
    try {
      final response = await _authenticatedDio.get('${Constant.URL}auth/',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
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

  // 프로필 변경
  Future<Response?> putUser(Map data) async {
    final accessToken = await loadAccess();
    try {
      final response = await _authenticatedDio.put('${Constant.URL}auth/',
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
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

final authService = AuthService();
