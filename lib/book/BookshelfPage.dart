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

  //책 목록(상태) 리스트 조회
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
            ),
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
              border: Border(
                  bottom: BorderSide(
                color: ref.watch(pageViewIndexProvider) == index
                    ? AppColors.black_4A
                    : Colors.transparent,
                width: 2.w,
              ))),
          child: Text(
            title,
            style: (ref.watch(pageViewIndexProvider) == index)
                ? const TextStyle(
                    color: AppColors.black_4A, fontWeight: FontWeight.bold)
                : const TextStyle(color: AppColors.grey_8D),
          )),
    );
  }

  Widget _bookselfList() {
    final pageViewIndex = ref.watch(pageViewIndexProvider);
    final bookStatusList = ref.watch(bookStatusListProvider);

    return Center(
        child: bookStatusList.isEmpty
            ? _bookshelfEmpty()
            : GridView(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.5,
                  crossAxisCount: 3,
                  crossAxisSpacing: 12.w,
                ),
                children: List.generate(
                  bookStatusList.length,
                  (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: (bookStatusList[index]
                                            ['book_image_url'] !=
                                        null)
                                    ? Image.network(
                                        width: 96.w,
                                        height: 142.h,
                                        fit: BoxFit.cover,
                                        bookStatusList[index]['book_image_url'],
                                      )
                                    : Container(
                                        width: 96.w,
                                        height: 142.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: AppColors.grey_F2,
                                        ),
                                      )),
                            Visibility(
                              visible: (pageViewIndex != 2),
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(bottom: 10.h),
                                width: 50.w,
                                height: 28.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    bottomLeft: Radius.circular(20.r),
                                  ),
                                  color: (pageViewIndex == 1)
                                      ? AppColors.black_4A
                                      : AppColors.grey_F2,
                                ),
                                child: Text(
                                  '${bookStatusList[index]['percent']}%',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: (pageViewIndex == 1)
                                          ? Colors.white
                                          : AppColors.black_4A),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 8.h),
                            alignment: Alignment.centerLeft,
                            height: 20.h,
                            child: Text(
                              bookStatusList[index]['book_title'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ))
                      ],
                    );
                  },
                ),
              ));
  }

  Widget _bookshelfEmpty() {
    final pageViewIndex = ref.watch(pageViewIndexProvider);

    return Container(
      margin: EdgeInsets.only(top: 84.h),
      child: Column(
        children: [
          Container(
            width: 200.r,
            height: 200.r,
            color: Colors.green,
          ),
          Container(
            margin: EdgeInsets.only(top: 16.h, bottom: 6.h),
            child: Text(
              '저장된 책이 없어요',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            (pageViewIndex == 0)
                ? '지금 읽고 있는 책이 있다면 추가해주세요'
                : (pageViewIndex == 1)
                    ? '책을 끝까지 다 읽은 후 찾아와주세요!'
                    : '나중에 읽고 싶은 책이 있다면\n책 추가하기에서 ‘읽고싶어요’를 눌러주세요',
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.grey_8D),
          ),
        ],
      ),
    );
  }
}
