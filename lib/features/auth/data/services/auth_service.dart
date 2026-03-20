import 'dart:core';

import 'package:book_flutter/core/network/dio_client.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/app_constant.dart';

class AuthService {
  final _dio = dioclent.dio;
  final _authenticatedDio = dioclent.authenticatedDio;

  Future<Response?> postLogin(Map data) async {
    try {
      final response = await _dio.post('${Constant.URL}auth/login', data: data);
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> postLogout() async {
    try {
      final response = await _authenticatedDio.post(
        '${Constant.URL}auth/logout',
      );
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> deleteUser() async {
    try {
      final response = await _authenticatedDio.delete(
        '${Constant.URL}auth/',
      );
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> postSignup(Map data) async {
    try {
      final response = await _dio.post('${Constant.URL}auth/', data: data);
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> postPwdFind(Map data) async {
    try {
      final response =
          await _dio.post('${Constant.URL}auth/find-password', data: data);
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> postPwdFindCheck(Map data) async {
    try {
      final response = await _dio
          .post('${Constant.URL}auth/find-password/check', data: data);
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> putPwdUpdate(Map data) async {
    try {
      final response = await _dio
          .put('${Constant.URL}auth/find-password/update-password', data: data);
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> getUser() async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}auth/',
      );
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
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
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }
}

final authService = AuthService();
