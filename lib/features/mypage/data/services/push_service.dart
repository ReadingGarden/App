import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/constants/app_constant.dart';
import '../../../../core/network/dio_client.dart';

class PushService {
  final _authenticatedDio = dioClient.authenticatedDio;

  Future<Response?> getPush() async {
    try {
      final response = await _authenticatedDio.get('${Constant.URL}push/');
      debugPrint('푸시 설정 조회 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint('푸시 설정 조회 실패 응답: ${e.response?.data}');
        debugPrint('푸시 설정 조회 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        debugPrint('푸시 설정 조회 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> putPush(Map data) async {
    try {
      final response =
          await _authenticatedDio.put('${Constant.URL}push/', data: data);
      debugPrint('푸시 설정 수정 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint('푸시 설정 수정 실패 응답: ${e.response?.data}');
        debugPrint('푸시 설정 수정 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        debugPrint('푸시 설정 수정 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }
}

final pushService = PushService();
