import 'package:dio/dio.dart';

import '../../utils/Constant.dart';
import '../../utils/SharedPreferences.dart';

class MemoService {
  final Dio _dio = Dio();

  //메모 리스트 조회
  Future<Response?> getMemoList(int page) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.get(
          '${Constant.URL}memo/?page=$page&page_size=10',
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

  //메모 작성
  Future<Response?> postMemo(Map data) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.post('${Constant.URL}memo/',
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

  //메모 수정
  Future<Response?> putMemo(int id, Map data) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.put('${Constant.URL}memo/?id=$id',
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

  //메모 이미지 업로드
  Future<Response?> postMemoImage(int id, String imagePath) async {
    final accessToken = await loadAccess();
    final formData =
        FormData.fromMap({'file': await MultipartFile.fromFile(imagePath)});
    try {
      final response = await _dio.post('${Constant.URL}memo/image?id=$id',
          data: formData,
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

  //메모 이미지 삭제
  Future<Response?> deleteMemoImage(int id) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.delete('${Constant.URL}memo/image?id=$id',
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

  //메모 삭제
  Future<Response?> deleteMemo(int id) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.delete('${Constant.URL}memo/?id=$id',
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

  //메모 즐겨찾기
  Future<Response?> putMemoLike(int id) async {
    final accessToken = await loadAccess();
    try {
      final response = await _dio.put('${Constant.URL}memo/like?id=$id',
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

final memoService = MemoService();
