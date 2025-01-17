import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

import '../utils/Router.dart';
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

    // 네트워크 에러 처리 추가
    void handleNetworkError(
        DioException error, ErrorInterceptorHandler handler) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        print("Connection Timeout: ${error.message}");
        _goToErrorPage();
      } else if (error.type == DioExceptionType.badResponse) {
        print("Bad Response: ${error.response?.statusCode}");
        if (error.response?.statusCode == 500) {
          _goToErrorPage();
        }
      } else if (error.type == DioExceptionType.unknown) {
        print("Unknown Error: ${error.message}");
        _goToErrorPage();
      } else {
        print("Dio Error: ${error.message}");
        _goToErrorPage();
      }
      handler.next(error); // 에러를 전달
    }

    // 네트워크 에러 인터셉터 추가
    dio.interceptors.add(InterceptorsWrapper(onError: handleNetworkError));
    authenticatedDio.interceptors
        .add(InterceptorsWrapper(onError: handleNetworkError));
  }

  void _goToErrorPage() {
    // GoRouter를 통해 에러 페이지로 이동
    final context = GoRouter.of(navigatorKey.currentContext!);
    context.pushReplacementNamed(
      'error',
    );
  }
}

final dioclent = DioClient();
