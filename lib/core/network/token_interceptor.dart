import 'package:book_flutter/core/logger.dart';
import 'package:dio/dio.dart';

import 'package:book_flutter/shared/constants/app_constant.dart';
import '../storage/token_storage.dart';

class TokenInterceptor extends Interceptor {
  final Dio _dio;

  TokenInterceptor(this._dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //요청 전에 토큰을 헤더에 추가
    final accessToken = await loadAccess();
    options.headers['Authorization'] = 'Bearer $accessToken';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    //401 Unauthorized 응답 처리
    if (err.response?.statusCode == 401) {
      logger.w('액세스 토큰 만료로 재발급을 시도합니다: $err');
      try {
        //토큰 갱신
        final newToken = await _getRefreshToken();

        //요청에 새 토큰을 추가하고 다시 시도
        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $newToken';

        final cloneRequest = await _dio.fetch(options);
        return handler.resolve(cloneRequest);
      } catch (e) {
        logger.e('토큰 재발급에 실패했습니다: $e');
        //토큰 갱신 실패시 에러 처리 (로그아웃 등)
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }

  Future<String> _getRefreshToken() async {
    final refreshToken = await loadRefresh();
    final response = await _dio.post('${Constant.URL}auth/refresh',
        data: {'refresh_token': refreshToken});
    logger.d('토큰 재발급 응답: ${response.data}');

    if (response.statusCode == 200) {
      final newAccessToken = response.data['data'];
      //새 토큰을 저장
      await saveAccess(newAccessToken);
      return newAccessToken;
    } else {
      throw Exception('Failed to refresh token');
    }
  }
}
