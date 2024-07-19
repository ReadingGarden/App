import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/service/BookService.dart';
import '../utils/Widgets.dart';

//총 페이지 입력 에러 상태 ...
final bookPageErrorProvider = StateProvider<String?>((ref) => null);

class BookUserWritePage extends ConsumerStatefulWidget {
  @override
  _BookUserWritePageState createState() => _BookUserWritePageState();
}

class _BookUserWritePageState extends ConsumerState<BookUserWritePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _pageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(bookPageErrorProvider.notifier).state = null;
    });
  }

  //총 페이지 입력 에러
  void _pageErrorValid() {
    if (int.tryParse(_pageController.text) == null) {
      ref.read(bookPageErrorProvider.notifier).state = '숫자를 입력해주세요';
    } else {
      ref.read(bookPageErrorProvider.notifier).state = null;
    }
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
                    ref.watch(bookPageErrorProvider),
                    bookPageErrorProvider,
                    validateFunction: _pageErrorValid),
              )
            ]),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin:
            EdgeInsets.only(bottom: 30.h, left: 20.w, right: 20.w, top: 10.h),
        child: Widgets.button('내 가든에 심기', true, () {
          if (_titleController.text.isNotEmpty &&
              _authorController.text.isNotEmpty &&
              _publisherController.text.isNotEmpty &&
              _pageController.text.isNotEmpty &&
              ref.watch(bookPageErrorProvider) == null) {
            context.pushNamed('book-register', extra: {
              'title': _titleController.text,
              'author': _authorController.text,
              'publisher': _publisherController.text,
              'page': _pageController.text
              //TODO
              // 'cover': ''
            });
          } else {
            // context.pushNamed('book-register', extra: {});
          }
          // postBook();
        }),
      ),
    );
  }
}
