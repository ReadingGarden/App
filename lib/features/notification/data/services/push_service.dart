import 'package:dio/dio.dart';

import 'package:book_flutter/core/logger.dart';
import 'package:book_flutter/shared/constants/app_constant.dart';
import '../../../../core/network/dio_client.dart';

class PushService {
  final _authenticatedDio = dioClient.authenticatedDio;

  Future<Response?> getPush() async {
    try {
      final response = await _authenticatedDio.get('${Constant.URL}push/');
      logger.d('푸시 설정 조회 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('푸시 설정 조회 실패 응답: ${e.response?.data}');
        logger.e('푸시 설정 조회 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('푸시 설정 조회 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> putPush(Map data) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}push/',
        data: data,
      );
      logger.d('푸시 설정 수정 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('푸시 설정 수정 실패 응답: ${e.response?.data}');
        logger.e('푸시 설정 수정 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('푸시 설정 수정 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }
}

final pushService = PushService();
