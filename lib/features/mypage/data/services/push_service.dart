import 'package:dio/dio.dart';

import '../../../../core/constants/app_constant.dart';
import '../../../../core/network/dio_client.dart';

class PushService {
  final _authenticatedDio = dioclent.authenticatedDio;

  Future<Response?> getPush() async {
    try {
      final response = await _authenticatedDio.get('${Constant.URL}push/');
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> putPush(Map data) async {
    try {
      final response =
          await _authenticatedDio.put('${Constant.URL}push/', data: data);
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }
}

final pushService = PushService();
