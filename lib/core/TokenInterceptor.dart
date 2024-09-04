import 'package:dio/dio.dart';

import '../utils/Constant.dart';
import '../utils/SharedPreferences.dart';

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
      print('-------------------------$err');
      try {
        //토큰 갱신
        final newToken = await _getRefreshToken();

        //요청에 새 토큰을 추가하고 다시 시도
        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $newToken';

        final cloneRequest = await _dio.fetch(options);
        return handler.resolve(cloneRequest);
      } catch (e) {
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
    print(response.data.toString());

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
