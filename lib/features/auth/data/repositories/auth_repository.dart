import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/token_storage.dart';
import '../services/auth_service.dart';
import '../../domain/entities/user_entity.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(authService);
});

class AuthRepository {
  AuthRepository(this._service);

  final AuthService _service;

  Future<UserEntity?> fetchUser() async {
    final response = await _service.getUser();
    if (response?.statusCode == 200) {
      return UserEntity.fromJson(
        Map<String, dynamic>.from(response?.data['data'] ?? {}),
      );
    }
    return null;
  }

  Future<int> updateUser(Map<String, dynamic> data) async {
    final response = await _service.putUser(data);
    return response?.statusCode ?? 0;
  }

  /// 이메일 로그인. 성공 시 토큰 저장 후 상태 코드 반환.
  Future<int> emailLogin(Map data) async {
    final response = await _service.postLogin(data);
    if (response?.statusCode == 200) {
      final token = response?.data?['data'];
      if (token != null) {
        saveAccess(token['access_token']);
        saveRefresh(token['refresh_token']);
      }
    }
    return response?.statusCode ?? 0;
  }

  /// 이메일 회원가입. 성공 시 토큰 저장 후 닉네임 반환.
  Future<({int statusCode, String? nick})> emailSignup(Map data) async {
    final response = await _service.postSignup(data);
    if (response?.statusCode == 201) {
      final token = response?.data?['data'];
      if (token != null) {
        saveAccess(token['access_token']);
        saveRefresh(token['refresh_token']);
      }
    }
    return (
      statusCode: response?.statusCode ?? 0,
      nick: response?.data?['data']?['user_nick'] as String?,
    );
  }

  /// 소셜 로그인 시도. 성공 시 토큰 저장, 400이면 회원가입 시도.
  Future<({String status, String? nick})> socialLogin(Map data) async {
    final Response? response = await _service.postLogin(data);
    if (response?.statusCode == 200) {
      final token = response?.data?['data'];
      if (token != null) {
        saveAccess(token['access_token']);
        saveRefresh(token['refresh_token']);
      }
      return (status: 'home', nick: null);
    } else if (response?.statusCode == 400) {
      return await socialSignup(data);
    }
    return (status: 'error', nick: null);
  }

  /// 소셜 회원가입. 성공 시 토큰 저장 후 닉네임 반환.
  Future<({String status, String? nick})> socialSignup(Map data) async {
    final Response? response = await _service.postSignup(data);
    if (response?.statusCode == 201) {
      final token = response?.data?['data'];
      if (token != null) {
        saveAccess(token['access_token']);
        saveRefresh(token['refresh_token']);
      }
      return (
        status: 'signup',
        nick: token?['user_nick'] as String?,
      );
    }
    return (status: 'error', nick: null);
  }
}
