import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/service/BookService.dart';
import '../utils/AppColors.dart';

final pageViewIndexProvider = StateProvider<int>((ref) => 0);
final bookStatusListProvider = StateProvider<List>((ref) => []);

class BookShelfPage extends ConsumerStatefulWidget {
  @override
  _BookShelfPageState createState() => _BookShelfPageState();
}

class _BookShelfPageState extends ConsumerState<BookShelfPage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(bookStatusListProvider.notifier).state = [];
      getBookStatusList(0);
    });
  }

  void getBookStatusList(int status) async {
    final response = await bookService.getBookStatusList(status);
    if (response?.statusCode == 200) {
      ref.read(bookStatusListProvider.notifier).state = response?.data['data'];
    }
  }

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
                color: AppColors.grey_F2,
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
                    getBookStatusList(page);
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
            duration: const Duration(milliseconds: 400), curve: Curves.ease);
        getBookStatusList(index);
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
        child: ref.watch(bookStatusListProvider).isEmpty
            ? _bookshelfEmpty()
            : GridView(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.57,
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 20.h),
                children: List.generate(
                  ref.watch(bookStatusListProvider).length,
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
                              ref.watch(bookStatusListProvider)[index]
                                  ['book_title'],
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
      color: Colors.white,
    );
  }
}
