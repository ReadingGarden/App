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
      return UserEntity.fromMap(
        Map<String, dynamic>.from(response?.data['data'] ?? {}),
      );
    }
    return null;
  }

  Future<int> updateUser(Map<String, dynamic> data) async {
    final response = await _service.putUser(data);
    return response?.statusCode ?? 0;
  }

  /// 소셜 로그인 시도. 성공 시 토큰 저장 후 true, 400이면 회원가입 시도.
  /// 반환: {'status': 'home'|'signup'|'error', 'nick': String?}
  Future<Map<String, dynamic>> socialLogin(Map data) async {
    final Response? response = await _service.postLogin(data);
    if (response?.statusCode == 200) {
      saveAccess(response?.data['data']['access_token']);
      saveRefresh(response?.data['data']['refresh_token']);
      return {'status': 'home'};
    } else if (response?.statusCode == 400) {
      return await socialSignup(data);
    }
    return {'status': 'error'};
  }

  /// 소셜 회원가입. 성공 시 토큰 저장 후 닉네임 반환.
  Future<Map<String, dynamic>> socialSignup(Map data) async {
    final Response? response = await _service.postSignup(data);
    if (response?.statusCode == 201) {
      saveAccess(response?.data['data']['access_token']);
      saveRefresh(response?.data['data']['refresh_token']);
      return {
        'status': 'signup',
        'nick': response?.data['data']['user_nick'],
      };
    }
    return {'status': 'error'};
  }
}
