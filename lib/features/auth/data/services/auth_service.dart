import 'dart:core';

import 'package:book_flutter/core/logger.dart';
import 'package:book_flutter/core/network/dio_client.dart';
import 'package:dio/dio.dart';

import 'package:book_flutter/shared/constants/app_constant.dart';

class AuthService {
  final _dio = dioClient.dio;
  final _authenticatedDio = dioClient.authenticatedDio;

  Future<Response?> postLogin(Map data) async {
    try {
      final response = await _dio.post('${Constant.URL}auth/login', data: data);
      logger.d('로그인 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('로그인 요청 실패 응답: ${e.response?.data}');
        logger.e('로그인 요청 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('로그인 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> postLogout() async {
    try {
      final response = await _authenticatedDio.post(
        '${Constant.URL}auth/logout',
      );
      logger.d('로그아웃 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('로그아웃 요청 실패 응답: ${e.response?.data}');
        logger.e('로그아웃 요청 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('로그아웃 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> deleteUser() async {
    try {
      final response = await _authenticatedDio.delete(
        '${Constant.URL}auth/',
      );
      logger.d('회원 탈퇴 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('회원 탈퇴 요청 실패 응답: ${e.response?.data}');
        logger.e('회원 탈퇴 요청 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('회원 탈퇴 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> postSignup(Map data) async {
    try {
      final response = await _dio.post('${Constant.URL}auth/', data: data);
      logger.d('회원가입 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('회원가입 요청 실패 응답: ${e.response?.data}');
        logger.e('회원가입 요청 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('회원가입 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> postPwdFind(Map data) async {
    try {
      final response =
          await _dio.post('${Constant.URL}auth/find-password', data: data);
      logger.d('비밀번호 찾기 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('비밀번호 찾기 요청 실패 응답: ${e.response?.data}');
        logger.e('비밀번호 찾기 요청 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('비밀번호 찾기 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> postPwdFindCheck(Map data) async {
    try {
      final response = await _dio
          .post('${Constant.URL}auth/find-password/check', data: data);
      logger.d('비밀번호 찾기 확인 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('비밀번호 찾기 확인 실패 응답: ${e.response?.data}');
        logger.e('비밀번호 찾기 확인 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('비밀번호 찾기 확인 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> putPwdUpdate(Map data) async {
    try {
      final response = await _dio
          .put('${Constant.URL}auth/find-password/update-password', data: data);
      logger.d('비밀번호 재설정 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('비밀번호 재설정 실패 응답: ${e.response?.data}');
        logger.e('비밀번호 재설정 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('비밀번호 재설정 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> getUser() async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}auth/',
      );
      logger.d('내 정보 조회 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('내 정보 조회 실패 응답: ${e.response?.data}');
        logger.e('내 정보 조회 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('내 정보 조회 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> putUser(Map data) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}auth/',
        data: data,
      );
      logger.d('내 정보 수정 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('내 정보 수정 실패 응답: ${e.response?.data}');
        logger.e('내 정보 수정 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('내 정보 수정 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }
}

final authService = AuthService();
