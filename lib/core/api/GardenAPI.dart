import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../service/GardenService.dart';

//가든 리스트 ...
final gardenListProvider = StateProvider<List>((ref) => []);
// [{garden_no: 26, garden_title: 하나더, garden_info: 추가, garden_color: black, garden_members: 1, book_count: 3, garden_created_at: 2024-07-23T06:34:34}, ... ]

//가든 메인 ...
final gardenMainProvider = StateProvider<Map>((ref) => {});
//  {garden_no: 26, garden_title: 하나더, garden_info: 추가, garden_color: black, garden_created_at: 2024-07-23T06:34:34, book_list: [{book_no: 9, book_isbn: 9788932916194, book_title: 창문 넘어 도망친 100세 노인, book_author: 요나스 요나손 (지은이), 임호경 (옮긴이), book_publisher: 열린책들, book_image_url: https://image.aladin.co.kr/product/2856/41/coversum/s932916195_2.jpg, book_status: 0, percent: 0, user_no: 34, book_page: 512}, {book_no: 10, book_isbn: 9788970940564, book_title: 달님 안녕, book_author: 하야시 아키코 (지은이), book_publisher: 한림출판사, book_image_url: https://image.aladin.co.kr/product/27/9/coversum/8970940561_2.jpg, book_status: 0, percent: 0, user_no: 34, book_page: 48}, {book_no: 16, book_isbn: 9791197606991, book_title: 안녕, 나의 한옥집 - 내 이야기는 그곳에서 시작되었다, 개정판, book_author: 임수진 (지은이), book_publis<…>

//가든 메인 책 리스트 ...
final gardenMainBookListProvider = StateProvider<List>((ref) => []);
// [{book_no: 7, book_title: 제목, book_author: 작가, book_publisher: 출판사, book_image_url: null, book_tree: , book_status: 0, percent: 0.0, book_page: 50, garden_no: 19}, ... ]

//가든 메인 멤버 리스트 ...
final gardenMainMemberListProvider = StateProvider<List>((ref) => []);

class GardenAPI {
  GardenAPI(this.ref);

  final WidgetRef ref;

  List gardenList() {
    return ref.watch(gardenListProvider);
  }

  Map gardenMain() {
    return ref.watch(gardenMainProvider);
  }

  List gardenMainBookList() {
    return ref.watch(gardenMainBookListProvider);
  }

  List gardenMainMemberList() {
    return ref.watch(gardenMainMemberListProvider);
  }

  void updateGardenList(List newState) {
    ref.read(gardenListProvider.notifier).state = newState;
  }

  void updateGardenMain(Map newState) {
    ref.read(gardenMainProvider.notifier).state = newState;
  }

  void updateGardenMainBookList(List newState) {
    ref.read(gardenMainBookListProvider.notifier).state = newState;
  }

  void updateGardenMainMemberList(List newState) {
    ref.read(gardenMainMemberListProvider.notifier).state = newState;
  }

  void resetGardenMain() {
    ref.read(gardenListProvider.notifier).state = [];
    ref.read(gardenMainProvider.notifier).state = {};
    ref.read(gardenMainBookListProvider.notifier).state = [];
  }

  void resetGardenMainMember() {
    ref.read(gardenMainMemberListProvider.notifier).state = [];
  }

  //MARK: - API
  //가든 리스트 조회 api
  void getGardenLsit() async {
    final response = await gardenService.getGardenList();
    if (response?.statusCode == 200) {
      updateGardenList(response?.data['data']);
      // 가든의 리스트의 첫번째를 상세 조회 (메인 가든 조회)
      getGardenDetail(ref.watch(gardenListProvider)[0]['garden_no']);
    }
  }

  //가든 상세 조회 api
  void getGardenDetail(int garden_no) async {
    final response = await gardenService.getGardenDetail(garden_no);
    if (response?.statusCode == 200) {
      updateGardenMain(response?.data['data']);
      updateGardenMainBookList(response?.data['data']['book_list']);
      updateGardenMainMemberList(response?.data['data']['garden_members']);
    }
  }

  //가든 메인 변경 api
  void putGardenMain(int garden_no) async {
    final response = await gardenService.putGardenMain(garden_no);
    if (response?.statusCode == 200) {
      getGardenLsit();
    }
  }
}
