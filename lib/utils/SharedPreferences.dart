import 'package:shared_preferences/shared_preferences.dart';

// access 토큰 저장
Future<void> saveAccess(String access) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('access', access);
}

// access 토큰 불러오기
Future<String?> loadAccess() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final access = prefs.getString('access');
  return access;
}

// refresh 토큰 저장
Future<void> saveRefresh(String refresh) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('refresh', refresh);
}

// refresh 토큰 불러오기
Future<String?> loadRefresh() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final refresh = prefs.getString('refresh');
  return refresh;
}

// 로그인 정보 지우기
Future<void> removeLoginInfo() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('access');
  await prefs.remove('refresh');
}

// 모든 정보 지우기
Future<void> removeLocalStorage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('access');
  await prefs.remove('refresh');
}
