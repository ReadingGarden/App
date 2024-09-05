import 'package:dio/dio.dart';

import '../../utils/Constant.dart';
import '../DioClient.dart';

class PushService {
  final _authenticatedDio = dioclent.authenticatedDio;

  //푸시 알림 조회
  Future<Response?> getPush() async {
    try {
      final response = await _authenticatedDio.get('${Constant.URL}push/');
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        // 서버가 응답한 경우 (상태 코드와 함께)
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        // 서버가 응답하지 않은 경우
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  //푸시 알림 수정
  Future<Response?> putPush(Map data) async {
    try {
      final response =
          await _authenticatedDio.put('${Constant.URL}push/', data: data);
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        // 서버가 응답한 경우 (상태 코드와 함께)
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        // 서버가 응답하지 않은 경우
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }
}

final pushService = PushService();
