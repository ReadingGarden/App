import 'package:dio/dio.dart';

import 'package:book_flutter/core/logger.dart';
import 'package:book_flutter/shared/constants/app_constant.dart';
import '../../../../core/network/dio_client.dart';

class BookService {
  final _authenticatedDio = dioClient.authenticatedDio;

  Future<Response?> getSerachBook(String query, int page) {
    return searchBooks(query, page);
  }

  Future<Response?> searchBooks(String query, int page) async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}book/search?query=$query&start=$page&maxResults=30',
      );
      logger.d('도서 검색 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('도서 검색 실패 응답: ${e.response?.data}');
        logger.e('도서 검색 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      }
      logger.e('도서 검색 요청 전송 실패: ${e.message}');
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
      logger.d('도서 상세 조회 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('도서 상세 조회 실패 응답: ${e.response?.data}');
        logger.e('도서 상세 조회 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      }
      logger.e('도서 상세 조회 요청 전송 실패: ${e.message}');
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
        logger.e('도서 중복 확인 실패 응답: ${e.response?.data}');
        logger.e('도서 중복 확인 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      }
      logger.e('도서 중복 확인 요청 전송 실패: ${e.message}');
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
      logger.d('도서 등록 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('도서 등록 실패 응답: ${e.response?.data}');
        logger.e('도서 등록 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      }
      logger.e('도서 등록 요청 전송 실패: ${e.message}');
      return null;
    }
  }

  Future<Response?> getBookRead(int bookNo) async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}book/read?book_no=$bookNo',
      );
      logger.d('독서 기록 조회 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('독서 기록 조회 실패 응답: ${e.response?.data}');
        logger.e('독서 기록 조회 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      }
      logger.e('독서 기록 조회 요청 전송 실패: ${e.message}');
      return null;
    }
  }

  Future<Response?> putBook(int bookNo, Map data) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}book/?book_no=$bookNo',
        data: data,
      );
      logger.d('도서 수정 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('도서 수정 실패 응답: ${e.response?.data}');
        logger.e('도서 수정 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      }
      logger.e('도서 수정 요청 전송 실패: ${e.message}');
      return null;
    }
  }

  Future<Response?> deleteBook(int bookNo) async {
    try {
      final response = await _authenticatedDio.delete(
        '${Constant.URL}book/?book_no=$bookNo',
      );
      logger.d('도서 삭제 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('도서 삭제 실패 응답: ${e.response?.data}');
        logger.e('도서 삭제 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      }
      logger.e('도서 삭제 요청 전송 실패: ${e.message}');
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
            ? '${Constant.URL}book/status?status=$status&page=$page&page_size=24'
            : '${Constant.URL}book/status?garden_no=$garden_no&status=$status&page=$page&page_size=24',
      );
      logger.d('도서 상태 목록 조회 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('도서 상태 목록 조회 실패 응답: ${e.response?.data}');
        logger.e('도서 상태 목록 조회 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      }
      logger.e('도서 상태 목록 조회 요청 전송 실패: ${e.message}');
      return null;
    }
  }

  Future<Response?> postBookRead(Map<String, dynamic> data) async {
    try {
      final response = await _authenticatedDio.post(
        '${Constant.URL}book/read',
        data: data,
      );
      logger.d('독서 기록 등록 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('독서 기록 등록 실패 응답: ${e.response?.data}');
        logger.e('독서 기록 등록 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      }
      logger.e('독서 기록 등록 요청 전송 실패: ${e.message}');
      return null;
    }
  }

  Future<Response?> putBookRead(int id, Map<String, dynamic> data) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}book/read?id=$id',
        data: data,
      );
      logger.d('독서 기록 수정 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('독서 기록 수정 실패 응답: ${e.response?.data}');
        logger.e('독서 기록 수정 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      }
      logger.e('독서 기록 수정 요청 전송 실패: ${e.message}');
      return null;
    }
  }
}

final bookService = BookService();
