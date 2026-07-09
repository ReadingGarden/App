import 'dart:async';

import 'package:book_flutter/core/logger.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

import 'package:book_flutter/shared/constants/app_constant.dart';
import '../../app/router/app_router.dart';
import '../storage/token_storage.dart';

class TokenInterceptor extends Interceptor {
  final Dio _dio;
  Completer<String>? _refreshCompleter;

  TokenInterceptor(this._dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //요청 전에 토큰을 헤더에 추가
    final accessToken = await loadAccess();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    //401 Unauthorized 응답 처리
    if (err.response?.statusCode == 401) {
      logger.w('액세스 토큰 만료로 재발급을 시도합니다: $err');
      try {
        //토큰 갱신 (동시 요청 시 첫 번째만 실제 갱신)
        final newToken = await _getRefreshToken();

        //요청에 새 토큰을 추가하고 다시 시도
        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $newToken';

        final cloneRequest = await _dio.fetch(options);
        return handler.resolve(cloneRequest);
      } catch (e) {
        logger.e('토큰 재발급에 실패했습니다: $e');
        await removeLoginInfo();
        final context = navigatorKey.currentContext;
        if (context != null) {
          GoRouter.of(context).goNamed('start');
        }
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }

  Future<String> _getRefreshToken() async {
    // 이미 갱신 중이면 결과를 공유
    if (_refreshCompleter != null) {
      return _refreshCompleter!.future;
    }

    _refreshCompleter = Completer<String>();
    try {
      final refreshToken = await loadRefresh();
      // 재발급 요청은 인터셉터가 없는 별도 Dio로 보낸다.
      // (인터셉터가 붙은 _dio를 쓰면 재발급 요청이 다시 401→onError로 재귀해 데드락)
      final refreshDio = Dio();
      final response = await refreshDio.post('${Constant.URL}auth/refresh',
          data: {'refresh_token': refreshToken});
      logger.d('토큰 재발급 응답: ${response.data}');

      if (response.statusCode == 200) {
        final newAccessToken = response.data['data'];
        await saveAccess(newAccessToken);
        _refreshCompleter!.complete(newAccessToken);
        return newAccessToken;
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      _refreshCompleter!.completeError(e);
      rethrow;
    } finally {
      _refreshCompleter = null;
    }
  }
}
