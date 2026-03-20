import 'package:dio/dio.dart';

import '../../../../core/constants/app_constant.dart';
import '../../../../core/network/dio_client.dart';

class MemoService {
  final _authenticatedDio = dioclent.authenticatedDio;

  Future<Response?> getMemoList(int page) async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}memo/?page=$page&page_size=10',
      );
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

  Future<Response?> postMemo(Map data) async {
    try {
      final response = await _authenticatedDio.post(
        '${Constant.URL}memo/',
        data: data,
      );
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

  Future<Response?> putMemo(int id, Map data) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}memo/?id=$id',
        data: data,
      );
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

  Future<Response?> postMemoImage(int id, String imagePath) async {
    final formData =
        FormData.fromMap({'file': await MultipartFile.fromFile(imagePath)});
    try {
      final response = await _authenticatedDio.post(
        '${Constant.URL}memo/image?id=$id',
        data: formData,
      );
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

  Future<Response?> deleteMemoImage(int id) async {
    try {
      final response = await _authenticatedDio.delete(
        '${Constant.URL}memo/image?id=$id',
      );
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

  Future<Response?> deleteMemo(int id) async {
    try {
      final response = await _authenticatedDio.delete(
        '${Constant.URL}memo/?id=$id',
      );
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

  Future<Response?> putMemoLike(int id) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}memo/like?id=$id',
      );
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

final memoService = MemoService();
