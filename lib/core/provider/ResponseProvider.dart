import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResponseProvider {
  //TODO - 필요에 따라 세분화
  final userMapProvider = StateProvider<Map?>((ref) => null);
  // {user_no: 34, user_nick: 냐하하, user_email: ella@acryl.ai, user_social_type: , user_image: image1, user_created_at: 2024-06-14T00:19:40, garden_count: 1, read_book_count: 0, like_book_count: 0}
}

final responseProvider = ResponseProvider();
