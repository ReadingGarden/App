import 'package:dio/dio.dart';

import '../../../../core/constants/app_constant.dart';
import '../../../../core/network/dio_client.dart';

class BookService {
  final _authenticatedDio = dioclent.authenticatedDio;

  Future<Response?> getSerachBook(String query, int page) {
    return searchBooks(query, page);
  }

  Future<Response?> searchBooks(String query, int page) async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}book/search?query=$query&start=$page&maxResults=30',
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

  Future<Response?> getDetailBook_ISBN(String isbn13) {
    return getBookByIsbn(isbn13);
  }

  Future<Response?> getBookByIsbn(String isbn13) async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}book/detail-isbn?query=$isbn13',
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

  Future<Response?> getBookDuplication(String isbn) {
    return checkBookDuplication(isbn);
  }

  Future<Response?> checkBookDuplication(String isbn) async {
    try {
      final response =
          await _authenticatedDio.get('${Constant.URL}book/?isbn=$isbn');
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

  Future<Response?> postBook(Map data) {
    return createWishBook(data);
  }

  Future<Response?> createWishBook(Map data) async {
    try {
      final response =
          await _authenticatedDio.post('${Constant.URL}book/', data: data);
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

  Future<Response?> getBookStatusList(
    int status,
    int page, {
    int? garden_no,
  }) async {
    try {
      final response = await _authenticatedDio.get(
        (garden_no == null)
            ? '${Constant.URL}book/status?status=$status&page=$page&page_size=10'
            : '${Constant.URL}book/status?garden_no=$garden_no&status=$status&page=$page&page_size=10',
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

  Future<Response?> postBookRead(Map<String, dynamic> data) async {
    try {
      final response = await _authenticatedDio.post(
        '${Constant.URL}book/read',
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

  Future<Response?> putBookRead(int id, Map<String, dynamic> data) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}book/read?id=$id',
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
}

final bookService = BookService();
