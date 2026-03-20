import 'package:dio/dio.dart';

import '../../../../core/constants/app_constant.dart';
import '../../../../core/network/dio_client.dart';

class GardenService {
  final _authenticatedDio = dioclent.authenticatedDio;

  Future<Response?> getGardenList() async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}garden/list',
      );
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> getGardenDetail(int garden_no) async {
    try {
      final response = await _authenticatedDio.get(
        '${Constant.URL}garden/detail?garden_no=$garden_no',
      );
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
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
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
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
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> deleteGarden(int garden_no) async {
    try {
      final response = await _authenticatedDio.delete(
        '${Constant.URL}garden/?garden_no=$garden_no',
      );
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> moveToGarden(int garden_no, int to_garden_no) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}garden/to?garden_no=$garden_no&to_garden_no=$to_garden_no',
      );
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> putGardenLeader(int garden_no, int user_no) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}garden/member?garden_no=$garden_no&user_no=$user_no',
      );
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> putGardenMain(int garden_no) async {
    try {
      final response = await _authenticatedDio.put(
        '${Constant.URL}garden/main?garden_no=$garden_no',
      );
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> byeGarden(int garden_no) async {
    try {
      final response = await _authenticatedDio.delete(
        '${Constant.URL}garden/member?garden_no=$garden_no',
      );
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }

  Future<Response?> postGardenInvite(int garden_no) async {
    try {
      final response = await _authenticatedDio.post(
        '${Constant.URL}garden/invite?garden_no=$garden_no',
      );
      print(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        return e.response;
      } else {
        print('Error sending request: ${e.message}');
        return null;
      }
    }
  }
}

final gardenService = GardenService();
