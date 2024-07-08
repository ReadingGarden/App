import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenProvider {
  final accessProvider = StateProvider<String?>((ref) => null);
}

final tokenProvider = TokenProvider();
