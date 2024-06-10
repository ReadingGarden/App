// import 'package:shared_preferences/shared_preferences.dart';

// // refresh 토큰 저장
// Future<void> saveRefresh(String refresh) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('refresh', refresh);
// }

// // refresh 토큰 불러오기
// Future<String?> loadRefresh() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final refresh = prefs.getString('refresh');
//   return refresh;
// }

// // refresh 토큰 지우기
// Future<void> removeLocalStorage() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.remove('refresh');
// }
