import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/AppColors.dart';

final pageViewIndexProvider = StateProvider<int>((ref) => 0);

class BookShelfPage extends ConsumerStatefulWidget {
  @override
  _BookShelfPageState createState() => _BookShelfPageState();
}

class _BookShelfPageState extends ConsumerState<BookShelfPage> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Text(
          '책장',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            height: 36.h,
            decoration: BoxDecoration(
              color: Colors.amber,
              border: Border(
                  bottom: BorderSide(
                width: 1.w,
              )),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _titleButton('읽고있어요', 0),
                _titleButton('다읽었어요', 1),
                _titleButton('읽고싶어요', 2)
              ],
            ),
          ),
          Expanded(
            child: Container(
                child: PageView.builder(
              itemCount: 3,
              controller: _pageController,
              onPageChanged: (int page) {
                ref.read(pageViewIndexProvider.notifier).state = page;
              },
              itemBuilder: (context, index) {
                return Container(
                  color: index == 0
                      ? Colors.red
                      : index == 1
                          ? Colors.green
                          : Colors.blue,
                  child: Center(
                    child: Text(
                      'Page ${index + 1}',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                );
              },
            )),
          ),
        ],
      ),
    );
  }

  Widget _titleButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        print('클릭하면 해당 인덱스 페이지 이동');
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      },
      child: Container(
          alignment: Alignment.center,
          width: 98.w,
          height: 36.h,
          decoration: BoxDecoration(
              color: ref.watch(pageViewIndexProvider) == index
                  ? Colors.red
                  : Colors.orange,
              border: Border(
                  bottom: BorderSide(
                color: ref.watch(pageViewIndexProvider) == index
                    ? Colors.black
                    : Colors.transparent,
                width: 1.w,
              ))),
          child: Text(title)),
    );
  }
}
