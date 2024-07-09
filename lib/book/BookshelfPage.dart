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
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            height: 36.h,
            decoration: BoxDecoration(
              // color: Colors.amber,
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
                margin: EdgeInsets.only(top: 20.h),
                child: PageView.builder(
                  itemCount: 3,
                  controller: _pageController,
                  onPageChanged: (int page) {
                    ref.read(pageViewIndexProvider.notifier).state = page;
                  },
                  itemBuilder: (context, index) {
                    return _bookselfList();
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
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      },
      child: Container(
          alignment: Alignment.center,
          width: 98.w,
          height: 36.h,
          decoration: BoxDecoration(
              color: Colors.transparent,
              // color: ref.watch(pageViewIndexProvider) == index
              //     ? Colors.red
              //     : Colors.orange,
              border: Border(
                  bottom: BorderSide(
                color: ref.watch(pageViewIndexProvider) == index
                    ? AppColors.primaryColor
                    : Colors.transparent,
                width: 2.w,
              ))),
          child: Text(
            title,
            style: TextStyle(color: AppColors.primaryColor),
          )),
    );
  }

  Widget _bookselfList() {
    return Center(
        child: ref.watch(pageViewIndexProvider) == 1
            ? _bookshelfEmpty()
            : GridView(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.57,
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 20.h),
                children: List.generate(
                  9,
                  (index) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          width: 96.w,
                          height: 142.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.blue),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            height: 20.h,
                            child: Text(
                              'texttexttexttexttext',
                              overflow: TextOverflow.ellipsis,
                            ))
                      ],
                    );
                  },
                ),
              ));
  }

  Widget _bookshelfEmpty() {
    return Container(
      color: Colors.red,
    );
  }
}
