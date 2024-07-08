import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResponseProvider {
  //TODO - 필요에 따라 세분화
  final userMapProvider = StateProvider<Map?>((ref) => null);
}

final responseProvider = ResponseProvider();
