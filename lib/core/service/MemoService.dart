import 'package:dio/dio.dart';

import '../../utils/Constant.dart';
import '../DioClient.dart';

class MemoService {
  final _authenticatedDio = dioclent.authenticatedDio;

  //메모 리스트 조회
  Future<Response?> getMemoList(int page) async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}memo/?page=$page&page_size=10',
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

  //메모 작성
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
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}memo/?id=$id',
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

  //메모 이미지 업로드
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
    try {
      final response = await _authenticatedDio.delete(
        '${Constant.URL}memo/image?id=$id',
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

  //메모 삭제
  Future<Response?> deleteMemo(int id) async {
    try {
      final response = await _authenticatedDio.delete(
        '${Constant.URL}memo/?id=$id',
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

  //메모 즐겨찾기
  Future<Response?> putMemoLike(int id) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}memo/like?id=$id',
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

final memoService = MemoService();
