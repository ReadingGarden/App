import 'package:flutter_riverpod/flutter_riverpod.dart';

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
}
