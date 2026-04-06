import 'package:dio/dio.dart';

import 'package:book_flutter/core/logger.dart';
import 'package:book_flutter/shared/constants/app_constant.dart';
import '../../../../core/network/dio_client.dart';

class GardenService {
  final _authenticatedDio = dioClient.authenticatedDio;

  Future<Response?> getGardenList() async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}garden/list',
      );
      logger.d('가든 목록 조회 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('가든 목록 조회 실패 응답: ${e.response?.data}');
        logger.e('가든 목록 조회 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('가든 목록 조회 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> getGardenDetail(int garden_no) async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}garden/detail?garden_no=$garden_no',
      );
      logger.d('가든 상세 조회 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('가든 상세 조회 실패 응답: ${e.response?.data}');
        logger.e('가든 상세 조회 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('가든 상세 조회 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> postGarden(Map data) async {
    try {
      final response = await _authenticatedDio.post(
        '${Constant.URL}garden/',
        data: data,
      );
      logger.d('가든 생성 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('가든 생성 실패 응답: ${e.response?.data}');
        logger.e('가든 생성 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('가든 생성 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> putGarden(int garden_no, Map data) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}garden/?garden_no=$garden_no',
        data: data,
      );
      logger.d('가든 수정 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('가든 수정 실패 응답: ${e.response?.data}');
        logger.e('가든 수정 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('가든 수정 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> deleteGarden(int garden_no) async {
    try {
      final response = await _authenticatedDio.delete(
        '${Constant.URL}garden/?garden_no=$garden_no',
      );
      logger.d('가든 삭제 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('가든 삭제 실패 응답: ${e.response?.data}');
        logger.e('가든 삭제 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('가든 삭제 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> moveToGarden(int garden_no, int to_garden_no) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}garden/to?garden_no=$garden_no&to_garden_no=$to_garden_no',
      );
      logger.d('가든 이동 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('가든 이동 실패 응답: ${e.response?.data}');
        logger.e('가든 이동 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('가든 이동 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> putGardenLeader(int garden_no, int user_no) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}garden/member?garden_no=$garden_no&user_no=$user_no',
      );
      logger.d('가든 대표 변경 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('가든 대표 변경 실패 응답: ${e.response?.data}');
        logger.e('가든 대표 변경 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('가든 대표 변경 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> putGardenMain(int garden_no) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}garden/main?garden_no=$garden_no',
      );
      logger.d('대표 가든 변경 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('대표 가든 변경 실패 응답: ${e.response?.data}');
        logger.e('대표 가든 변경 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('대표 가든 변경 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> byeGarden(int garden_no) async {
    try {
      final response = await _authenticatedDio.delete(
        '${Constant.URL}garden/member?garden_no=$garden_no',
      );
      logger.d('가든 나가기 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('가든 나가기 실패 응답: ${e.response?.data}');
        logger.e('가든 나가기 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('가든 나가기 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> postGardenInvite(int garden_no) async {
    try {
      final response = await _authenticatedDio.post(
        '${Constant.URL}garden/invite?garden_no=$garden_no',
      );
      logger.d('가든 초대 링크 생성 응답: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.e('가든 초대 링크 생성 실패 응답: ${e.response?.data}');
        logger.e('가든 초대 링크 생성 실패 상태 코드: ${e.response?.statusCode}');
        return e.response;
      } else {
        logger.e('가든 초대 링크 생성 요청 전송 실패: ${e.message}');
        return null;
      }
    }
  }
}

final gardenService = GardenService();
