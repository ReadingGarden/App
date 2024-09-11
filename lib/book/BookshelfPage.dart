import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/model/Book.dart';
import '../core/provider/BookStatusListNotifier.dart';
import '../core/service/BookService.dart';
import '../utils/AppColors.dart';

final pageViewIndexProvider = StateProvider<int>((ref) => 0);

class BookShelfPage extends ConsumerStatefulWidget {
  @override
  _BookShelfPageState createState() => _BookShelfPageState();
}

class _BookShelfPageState extends ConsumerState<BookShelfPage> {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  int _currentPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(bookStatusListProvider.notifier).reset();
      ref.read(pageViewIndexProvider.notifier).state = 0;
      getBookStatusList(0);
    });

    _scrollController.addListener(() {
      // 스크롤이 마지막에 도달했을 때 추가 데이터를 로드
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getBookStatusList(ref.watch(pageViewIndexProvider));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  //책 목록(상태) 리스트 조회 api
  void getBookStatusList(int status) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final response = await bookService.getBookStatusList(status, _currentPage);
    if (response?.statusCode == 200) {
      final List<dynamic> bookStatusList = response?.data['data']['list'];
      final List<Book> newBookStatusList = bookStatusList
          .map((json) => Book(
              book_no: json['book_no'],
              book_title: json['book_title'],
              book_author: json['book_author'],
              book_publisher: json['book_publisher'],
              book_image_url: json['book_image_url'],
              book_tree: json['book_tree'],
              book_status: json['book_status'],
              percent: json['percent'],
              book_page: json['book_page'],
              garden_no: json['garden_no']))
          .toList();

      if (newBookStatusList.isNotEmpty) {
        ref
            .read(bookStatusListProvider.notifier)
            .addBookStatusList(newBookStatusList);
        setState(() {
          _currentPage++;
        });
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leadingWidth: 0,
        leading: Container(),
        centerTitle: false,
        titleSpacing: 24.w,
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
                ref.read(bookStatusListProvider.notifier).reset();
                _currentPage = 1;
                getBookStatusList(page);

                ref.read(pageViewIndexProvider.notifier).state = page;
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
        ref.read(bookStatusListProvider.notifier).reset();
        _currentPage = 1;
        getBookStatusList(index);

        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 400), curve: Curves.ease);
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
            : RefreshIndicator(
                onRefresh: () async {
                  ref.read(bookStatusListProvider.notifier).reset();
                  _currentPage = 1;
                  getBookStatusList(pageViewIndex);
                },
                child: GridView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.5,
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.w,
                  ),
                  children: List.generate(
                    bookStatusList.length,
                    (index) {
                      return GestureDetector(
                        onTap: () async {
                          if (pageViewIndex == 2) {
                            final data = {
                              'book_no':
                                  bookStatusList[index].toJson()['book_no'],
                              'title':
                                  bookStatusList[index].toJson()['book_title'],
                              'author':
                                  bookStatusList[index].toJson()['book_author'],
                              'publisher': bookStatusList[index]
                                  .toJson()['book_publisher'],
                              //TODO: - 책 소개 DB 수정
                              'description': bookStatusList[index]
                                  .toJson()['book_publisher'],
                              'cover': bookStatusList[index]
                                  .toJson()['book_image_url'],
                              'itemPage':
                                  bookStatusList[index].toJson()['book_page'],
                            };

                            context.pushNamed('book-add-garden',
                                extra: {'isbn13': 'null', 'book': data});
                          } else {
                            final response = await context.pushNamed(
                                'book-detail',
                                extra: bookStatusList[index].book_no);
                            if (response != null) {
                              ref.read(bookStatusListProvider.notifier).reset();
                              _currentPage = 1;
                              getBookStatusList(pageViewIndex);
                            }
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: (bookStatusList[index]
                                                .book_image_url !=
                                            null)
                                        ? Image.network(
                                            width: 96.w,
                                            height: 142.h,
                                            fit: BoxFit.cover,
                                            bookStatusList[index]
                                                .book_image_url!,
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
                                      '${bookStatusList[index].percent.floor()}%',
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
                                  bookStatusList[index].book_title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ))
                          ],
                        ),
                      );
                    },
                  ),
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
