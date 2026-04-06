import 'package:dio/dio.dart';

import 'package:book_flutter/core/logger.dart';
import 'package:book_flutter/shared/constants/app_constant.dart';
import '../../../../core/network/dio_client.dart';

class MemoService {
  final _authenticatedDio = dioClient.authenticatedDio;

  Future<Response?> getMemoList(int page) async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}memo/?page=$page&page_size=10',
      );
      logger.d('메모 목록 조회 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('메모 목록 조회 실패 응답: ${e.response?.data}');
        logger.e('메모 목록 조회 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('메모 목록 조회 요청 전송 실패: ${e.message}');
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
      logger.d('메모 등록 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('메모 등록 실패 응답: ${e.response?.data}');
        logger.e('메모 등록 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('메모 등록 요청 전송 실패: ${e.message}');
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
      logger.d('메모 수정 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('메모 수정 실패 응답: ${e.response?.data}');
        logger.e('메모 수정 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('메모 수정 요청 전송 실패: ${e.message}');
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
      logger.d('메모 이미지 업로드 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('메모 이미지 업로드 실패 응답: ${e.response?.data}');
        logger.e('메모 이미지 업로드 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('메모 이미지 업로드 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> deleteMemoImage(int id) async {
    try {
      final response = await _authenticatedDio.delete(
        '${Constant.URL}memo/image?id=$id',
      );
      logger.d('메모 이미지 삭제 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('메모 이미지 삭제 실패 응답: ${e.response?.data}');
        logger.e('메모 이미지 삭제 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('메모 이미지 삭제 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> deleteMemo(int id) async {
    try {
      final response = await _authenticatedDio.delete(
        '${Constant.URL}memo/?id=$id',
      );
      logger.d('메모 삭제 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('메모 삭제 실패 응답: ${e.response?.data}');
        logger.e('메모 삭제 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('메모 삭제 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> putMemoLike(int id) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}memo/like?id=$id',
      );
      logger.d('메모 좋아요 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('메모 좋아요 실패 응답: ${e.response?.data}');
        logger.e('메모 좋아요 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('메모 좋아요 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }
}

final memoService = MemoService();
