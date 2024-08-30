import 'package:flutter_riverpod/flutter_riverpod.dart';

//Memo 모델
class Memo {
  final int id;
  final int book_no;
  final String book_title;
  final String book_author;
  final String? book_image_url;
  final String memo_content;
  final bool memo_like;
  final String? image_url;
  final String memo_created_at;

  Memo(
      {required this.id,
      required this.book_no,
      required this.book_title,
      required this.book_author,
      this.book_image_url,
      required this.memo_content,
      required this.memo_like,
      this.image_url,
      required this.memo_created_at});

  factory Memo.fromJson(Map<String, dynamic> json) {
    return Memo(
        id: json['id'],
        book_no: json['book_no'],
        book_title: json['book_title'],
        book_author: json['book_author'],
        book_image_url: json['book_image_url'],
        memo_content: json['memo_content'],
        memo_like: json['memo_like'],
        image_url: json['image_url'],
        memo_created_at: json['memo_created_at']);
  }
}

//TODO: - 프로바이더 분리
// Memo 리스트를 관리하는 StateNotifierProvider
final memoListProvider =
    StateNotifierProvider<MemoListNotifier, List<Memo>>((ref) {
  return MemoListNotifier();
});

class MemoListNotifier extends StateNotifier<List<Memo>> {
  MemoListNotifier() : super([]);

  void addMemoList(List<Memo> newMemoList) {
    state = [...state, ...newMemoList];
  }
}
