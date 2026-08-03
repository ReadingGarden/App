import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:book_flutter/shared/widgets/app_widgets.dart';

//책 제목 입력 에러 상태 ...
final bookTitleErrorProvider = StateProvider<String?>((ref) => null);
//총 페이지 입력 에러 상태 ...
final bookPageErrorProvider = StateProvider<String?>((ref) => null);

class BookUserWritePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<BookUserWritePage> createState() => _BookUserWritePageState();

  const BookUserWritePage({super.key});
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
      ref.read(bookTitleErrorProvider.notifier).state = null;
      ref.read(bookPageErrorProvider.notifier).state = null;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _publisherController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  //책 제목 입력 에러
  void _titleErrorValid() {
    ref.read(bookTitleErrorProvider.notifier).state =
        _titleController.text.isEmpty ? '제목은 필수예요' : null;
  }

  //총 페이지 입력 에러
  void _pageErrorValid() {
    if (_pageController.text.isEmpty) {
      ref.read(bookPageErrorProvider.notifier).state = '페이지 수는 필수예요';
    } else if (int.tryParse(_pageController.text) == null) {
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
            margin: REdgeInsets.only(top: 20.h, bottom: 20.h),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 4.h),
                  alignment: Alignment.center,
                  child: Widgets.textfield(
                    ref,
                    _titleController,
                    '책 제목',
                    '제목을 입력해주세요',
                    ref.watch(bookTitleErrorProvider),
                    bookTitleErrorProvider,
                    validateFunction: _titleErrorValid,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 4.h),
                  alignment: Alignment.center,
                  child: Widgets.textfield(
                    ref,
                    _authorController,
                    '작가',
                    '작가명을 입력해주세요',
                    null,
                    StateProvider((ref) => null),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 4.h),
                  alignment: Alignment.center,
                  child: Widgets.textfield(
                    ref,
                    _publisherController,
                    '출판사',
                    '출판사명을 입력해주세요',
                    null,
                    StateProvider((ref) => null),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 4.h),
                  alignment: Alignment.center,
                  child: Widgets.textfield(
                    ref,
                    _pageController,
                    '총 페이지',
                    '총 페이지 수를 입력해주세요',
                    ref.watch(bookPageErrorProvider),
                    bookPageErrorProvider,
                    validateFunction: _pageErrorValid,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Widgets.bottomBar(
        context,
        child: Widgets.button('내 가든에 심기', true, () {
          _titleErrorValid();
          _pageErrorValid();
          if (ref.read(bookTitleErrorProvider) == null &&
              ref.read(bookPageErrorProvider) == null) {
            context.pushNamed(
              'book-register',
              extra: {
                'title': _titleController.text,
                'author': _authorController.text,
                'publisher': _publisherController.text,
                'description': '',
                'isbn13': '',
                'cover': null,
                'itemPage': int.tryParse(_pageController.text) ?? 0,
                'book_no': null,
              },
            );
          }
        }),
      ),
    );
  }
}
