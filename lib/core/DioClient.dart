import 'package:dio/dio.dart';

import 'TokenInterceptor.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;
  late Dio authenticatedDio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio(); // 인증이 필요하지 않은 요청용
    authenticatedDio = Dio(); // 인증이 필요한 요청용

    // 인터셉터 추가
    final tokenInterceptor = TokenInterceptor(authenticatedDio);
    authenticatedDio.interceptors.add(tokenInterceptor);
  }
}

final dioclent = DioClient();
