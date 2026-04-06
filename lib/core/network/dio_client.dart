import 'package:book_flutter/core/logger.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

import '../../app/error_page.dart';
import '../../app/router/app_router.dart';
import 'token_interceptor.dart';

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
        logger.e('네트워크 연결 시간 초과: ${error.message}');
        _goToErrorPage(ErrorType.network);
      } else if (error.type == DioExceptionType.connectionError) {
        logger.e('네트워크 연결 오류: ${error.message}');
        _goToErrorPage(ErrorType.network);
      } else if (error.type == DioExceptionType.badResponse) {
        logger.w('잘못된 서버 응답 상태 코드: ${error.response?.statusCode}');
        if (error.response?.statusCode == 500) {
          _goToErrorPage(ErrorType.server);
        }
      } else if (error.type == DioExceptionType.unknown) {
        logger.e('알 수 없는 네트워크 오류: ${error.message}');
        _goToErrorPage(ErrorType.network);
      } else {
        logger.e('Dio 네트워크 오류: ${error.message}');
        _goToErrorPage(ErrorType.server);
      }
      handler.next(error); // 에러를 전달
    }

    // 네트워크 에러 인터셉터 추가
    dio.interceptors.add(InterceptorsWrapper(onError: handleNetworkError));
    authenticatedDio.interceptors
        .add(InterceptorsWrapper(onError: handleNetworkError));
  }

  void _goToErrorPage(ErrorType errorType) {
    final context = GoRouter.of(navigatorKey.currentContext!);
    context.pushReplacementNamed('error', extra: errorType);
  }
}

final dioClient = DioClient();
