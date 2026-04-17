import 'package:book_flutter/core/logger.dart';
import 'package:book_flutter/core/network/dio_client.dart';
import 'package:book_flutter/shared/constants/app_constant.dart';
import 'package:dio/dio.dart';

class AppService {
  final _dio = dioClient.dio;

  Future<Response?> getMinVersion() async {
    try {
      final response = await _dio.get('${Constant.URL}app/version');
      logger.d('앱 버전 조회 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('앱 버전 조회 실패 응답: ${e.response?.data}');
        logger.e('앱 버전 조회 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('앱 버전 조회 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }
}

final appService = AppService();
