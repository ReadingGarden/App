import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/service/BookService.dart';
import '../utils/Widgets.dart';

// final bookTitleErrorProvider = StateProvider<String?>((ref) => null);

class BookUserWritePage extends ConsumerStatefulWidget {
  @override
  _BookUserWritePageState createState() => _BookUserWritePageState();
}

class _BookUserWritePageState extends ConsumerState<BookUserWritePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _pageController = TextEditingController();

  void postBook() async {
    final data = {
      //TODO - 다음 페이지에서 해라
      "garden_no": 19,
      "book_title": _titleController.text,
      "book_author": _authorController.text,
      "book_publisher": _publisherController.text,
      "book_tree": "",
      // "book_image_url": null,
      "book_status": 0,
      "book_page": _pageController.text
    };
    final response = await bookService.postBook(data);
    if (response?.statusCode == 201) {
    } else if (response?.statusCode == 401) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context, title: '직접 입력하기'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            margin: REdgeInsets.only(bottom: 20.h),
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.only(
                    left: 24.w, right: 24.w, bottom: 12.h, top: 6.h),
                alignment: Alignment.center,
                child: Widgets.textfield(
                    ref,
                    _titleController,
                    '책 제목',
                    '제목을 입력해주세요',
                    null,
                    StateProvider(
                      (ref) => null,
                    )),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.only(
                    left: 24.w, right: 24.w, bottom: 12.h, top: 6.h),
                alignment: Alignment.center,
                child: Widgets.textfield(
                    ref,
                    _authorController,
                    '작가',
                    '작가명을 입력해주세요',
                    null,
                    StateProvider(
                      (ref) => null,
                    )),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.only(
                    left: 24.w, right: 24.w, bottom: 12.h, top: 6.h),
                alignment: Alignment.center,
                child: Widgets.textfield(
                    ref,
                    _publisherController,
                    '출판사',
                    '출판사명을 입력해주세요',
                    null,
                    StateProvider(
                      (ref) => null,
                    )),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 24.w, right: 24.w, bottom: 12.h, top: 6.h),
                alignment: Alignment.center,
                child: Widgets.textfield(
                    ref,
                    _pageController,
                    '총 페이지',
                    '총 페이지 수를 입력해주세요',
                    null,
                    StateProvider(
                      (ref) => null,
                    )),
              )
            ]),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin:
            EdgeInsets.only(bottom: 30.h, left: 20.w, right: 20.w, top: 10.h),
        child: Widgets.button('내 가든에 심기', true, () => postBook()),
      ),
    );
  }
}
