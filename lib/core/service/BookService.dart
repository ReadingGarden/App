import 'package:dio/dio.dart';

import '../../utils/Constant.dart';
import '../DioClient.dart';

class BookService {
  final _authenticatedDio = dioclent.authenticatedDio;

  //책 검색
  Future<Response?> getSerachBook(String query, int page) async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}book/search?query=$query&start=$page&maxResults=30',
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

  //책 상세 조회
  Future<Response?> getDetailBook_ISBN(String query) async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}book/detail-isbn?query=$query',
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

  // 책 등록
  Future<Response?> postBook(Map data) async {
    try {
      final response =
          await _authenticatedDio.post('${Constant.URL}book/', data: data);
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
    try {
      final response = await _authenticatedDio
          .put('${Constant.URL}book/?book_no=$book_no', data: data);
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
    try {
      final response = await _authenticatedDio.delete(
        '${Constant.URL}book/?book_no=$book_no',
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

  //독서 기록 조회
  Future<Response?> getBookRead(int book_no) async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}book/read?book_no=$book_no',
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

  //독서 기록 추가
  Future<Response?> postBookRead(Map data) async {
    try {
      final response = await _authenticatedDio.post(
        '${Constant.URL}book/read',
        data: data,
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

  //독서 기록 수정
  Future<Response?> putBookRead(int id, Map data) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}book/read?id=$id',
        data: data,
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
}

final bookService = BookService();
