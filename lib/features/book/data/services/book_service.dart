import 'package:dio/dio.dart';

import '../../../../utils/Constant.dart';
import '../../../../core/network/dio_client.dart';

class BookService {
  final _authenticatedDio = dioclent.authenticatedDio;

  Future<Response?> getBookRead(int bookNo) async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}book/read?book_no=$bookNo',
      );
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      }
      print('Error sending request: ${e.message}');
      return null;
    }
  }

  Future<Response?> putBook(int bookNo, Map data) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}book/?book_no=$bookNo',
        data: data,
      );
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      }
      print('Error sending request: ${e.message}');
      return null;
    }
  }

  Future<Response?> deleteBook(int bookNo) async {
    try {
      final response = await _authenticatedDio.delete(
        '${Constant.URL}book/?book_no=$bookNo',
      );
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      }
      print('Error sending request: ${e.message}');
      return null;
    }
  }
}
