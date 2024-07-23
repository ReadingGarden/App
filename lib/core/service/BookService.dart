import 'package:dio/dio.dart';

import '../../utils/Constant.dart';
import '../../utils/SharedPreferences.dart';

class BookService {
  final Dio _dio = Dio();

  //책 검색
  Future<Response?> getSerachBook(String query) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.get('${Constant.URL}book/search?query=$query',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
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

  //책 상세 조회
  Future<Response?> getDetailBook_ISBN(String query) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.get(
          '${Constant.URL}book/detail-isbn?query=$query',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
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

  // 책 등록
  Future<Response?> postBook(Map data) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.post('${Constant.URL}book/',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          data: data);
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

  // 책 수정
  Future<Response?> putBook(int book_no, Map data) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.post('${Constant.URL}book/?book_no=$book_no',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          data: data);
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

  // 책 삭제
  Future<Response?> deleteBook(int book_no) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.delete(
        '${Constant.URL}book/?book_no=$book_no',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
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

  // 책 목록(상태) 리스트 조회
  Future<Response?> getBookStatusList(
    int status, {
    int? garden_no,
  }) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.get(
          (garden_no == null)
              ? '${Constant.URL}book/status?status=$status'
              : '${Constant.URL}book/status?garden_no=$garden_no&status=$status',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
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

  //독서 기록 추가
  Future<Response?> postBookRead(Map data) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.post('${Constant.URL}book/read',
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
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

final bookService = BookService();
