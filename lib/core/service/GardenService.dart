import 'package:dio/dio.dart';

import '../../utils/Constant.dart';
import '../../utils/SharedPreferences.dart';

class GardenService {
  final Dio _dio = Dio();

  //가든 리스트 조회
  Future<Response?> getGardenList() async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.get('${Constant.URL}garden/list',
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

  //가든 상세 조회
  Future<Response?> getGardenDetail(int garden_no) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.get(
          '${Constant.URL}garden/detail?garden_no=$garden_no',
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

  //가든 추가
  Future<Response?> postGarden(Map data) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.post('${Constant.URL}garden/',
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

  //가든 수정
  Future<Response?> putGarden(int garden_no, Map data) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.put(
          '${Constant.URL}garden/?garden_no=$garden_no',
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

  //가든 삭제
  Future<Response?> deleteGarden(int garden_no) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.delete(
          '${Constant.URL}garden/?garden_no=$garden_no',
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

  //가든 책 이동
  Future<Response?> moveToGarden(int garden_no, int to_garden_no) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.put(
          '${Constant.URL}garden/to?garden_no=$garden_no&to_garden_no=$to_garden_no',
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

  //가든 대표 변경
  Future<Response?> putGardenLeader(int garden_no, int user_no) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.put(
          '${Constant.URL}garden/member?garden_no=$garden_no&user_no=$user_no',
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

  //가든 메인 변경
  Future<Response?> putGardenMain(int garden_no) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.put(
          '${Constant.URL}garden/main?garden_no=$garden_no',
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

  //가든 나가기
  Future<Response?> byeGarden(int garden_no) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.delete(
          '${Constant.URL}garden/member?garden_no=$garden_no',
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

final gardenService = GardenService();
