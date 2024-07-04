import 'package:flutter_riverpod/flutter_riverpod.dart';

//User 데이터 모델
class User {
  final int user_no;
  final String user_nick;
  final String user_email;
  final String user_social_type;
  final String user_image;
  final String user_created_at;
  final int? garden_count;
  final int? read_book_count;
  final int? like_book_count;

  User({
    required this.user_no,
    required this.user_nick,
    required this.user_email,
    required this.user_social_type,
    required this.user_image,
    required this.user_created_at,
    this.garden_count,
    this.read_book_count,
    this.like_book_count,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
        user_no: data['user_no'],
        user_nick: data['user_nick'],
        user_email: data['user_email'],
        user_social_type: data['user_social_type'],
        user_image: data['user_image'],
        user_created_at: data['user_created_at'],
        garden_count: data['garden_count'],
        read_book_count: data['read_book_count'],
        like_book_count: data['like_book_count']);
  }

  Map<String, dynamic> toJson() {
    return {
      'user_no': user_no,
      'user_nick': user_nick,
      'user_email': user_email,
      'user_social_type': user_social_type,
      'user_image': user_image,
      'user_created_at': user_created_at,
      'garden_count': garden_count,
      'read_book_count': read_book_count,
      'like_book_count': like_book_count
    };
  }
}

// User 상태 관리 Notifier
class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void updateUser(User user) {
    state = user;
  }
}

// UserProvider
final userProvider =
    StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier());
