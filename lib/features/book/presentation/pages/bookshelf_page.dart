import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:book_flutter/app/navigation/bottom_navi_page.dart';
import 'package:book_flutter/core/ui/app_assets.dart';
import 'package:book_flutter/core/ui/app_colors.dart';
import 'package:book_flutter/core/ui/app_widgets.dart';
import 'package:book_flutter/features/book/presentation/providers/book_search_provider.dart';

class BookShelfPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<BookShelfPage> createState() => _BookShelfPageState();

  const BookShelfPage({super.key});
}

class _BookShelfPageState extends ConsumerState<BookShelfPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  late AnimationController _listAnimController;
  int _prevBookCount = 0;
  int _prevNavIndex = -1;

  @override
  void initState() {
    super.initState();
    _listAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    Future.microtask(() {
      resetBookshelf(ref);
      ref.read(bookshelfPageViewIndexProvider.notifier).state = 0;
      fetchBookshelfBooks(ref, 0);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchBookshelfBooks(
          ref,
          ref.read(bookshelfPageViewIndexProvider),
          scroll: true,
        );
      }
    });
  }

  @override
  void dispose() {
    _listAnimController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(bookshelfLoadingProvider);
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
          _TabBar(
            pageController: _pageController,
            currentIndex: ref.watch(bookshelfPageViewIndexProvider),
            onTap: (index) {
              _pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            },
          ),
          Expanded(
            child: PageView.builder(
              itemCount: 3,
              controller: _pageController,
              onPageChanged: (int page) {
                resetBookshelf(ref);
                fetchBookshelfBooks(ref, page);
                ref.read(bookshelfPageViewIndexProvider.notifier).state = page;
              },
              itemBuilder: (context, index) {
                return _bookselfList(isLoading);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookselfList(bool isLoading) {
    final pageViewIndex = ref.watch(bookshelfPageViewIndexProvider);
    final bookStatusList = ref.watch(bookshelfBooksProvider);
    final navIndex = ref.watch(currentIndexProvider);

    if (bookStatusList.isNotEmpty &&
        (bookStatusList.length != _prevBookCount || navIndex != _prevNavIndex)) {
      _prevBookCount = bookStatusList.length;
      _prevNavIndex = navIndex;
      _listAnimController.forward(from: 0);
    }

    return Center(
        child: (isLoading && bookStatusList.isEmpty)
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.primaryColor,
                  color: AppColors.grey_CA,
                ),
              )
            : bookStatusList.isEmpty
                ? _bookshelfEmpty()
                : RefreshIndicator(
                    onRefresh: () async {
                      resetBookshelf(ref);
                      await fetchBookshelfBooks(ref, pageViewIndex);
                    },
                    backgroundColor: Colors.white,
                    color: AppColors.grey_8D,
                    child: GridView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      padding:
                          EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio:
                            MediaQuery.of(context).size.aspectRatio / 0.85,
                        crossAxisCount: 3,
                        crossAxisSpacing: 12.w,
                      ),
                      children: List.generate(
                        bookStatusList.length,
                        (index) {
                          final delay = (index * 0.05).clamp(0.0, 0.7);
                          final end = (delay + 0.3).clamp(0.0, 1.0);
                          final animation = CurvedAnimation(
                            parent: _listAnimController,
                            curve: Interval(delay, end, curve: Curves.easeOut),
                          );
                          return AnimatedBuilder(
                            animation: animation,
                            builder: (context, child) {
                              return Opacity(
                                opacity: animation.value,
                                child: Transform.translate(
                                  offset: Offset(0, 16 * (1 - animation.value)),
                                  child: child,
                                ),
                              );
                            },
                            child: Pressable(
                            onTap: () async {
                              if (pageViewIndex == 2) {
                                final data = {
                                  'book_no': bookStatusList[index].bookNo,
                                  'title': bookStatusList[index].bookTitle,
                                  'author': bookStatusList[index].bookAuthor,
                                  'publisher':
                                      bookStatusList[index].bookPublisher,
                                  'description': bookStatusList[index].bookInfo,
                                  'cover': bookStatusList[index].bookImageUrl,
                                  'itemPage': bookStatusList[index].bookPage,
                                };

                                context.pushNamed('book-add-garden',
                                    extra: {'isbn13': 'null', 'book': data});
                              } else {
                                final result = await context.pushNamed(
                                  'book-detail',
                                  extra: bookStatusList[index].bookNo,
                                );
                                if (result != null) {
                                  resetBookshelf(ref);
                                  fetchBookshelfBooks(ref, pageViewIndex);
                                }
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(
                                            offset: const Offset(0, 4),
                                            blurRadius: 16.r,
                                            color: AppColors.black_59
                                                .withValues(alpha: 0.1))
                                      ]),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          child: (bookStatusList[index]
                                                      .bookImageUrl !=
                                                  null)
                                              ? Image.network(
                                                  width: 96.w,
                                                  height: 132.h,
                                                  fit: BoxFit.cover,
                                                  bookStatusList[index]
                                                      .bookImageUrl!,
                                                )
                                              : Container(
                                                  width: 96.w,
                                                  height: 132.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                    color: AppColors.grey_F2,
                                                  ),
                                                )),
                                    ),
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
                                                ? AppColors.black_59
                                                : Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 16.r,
                                                  color: AppColors.black_59
                                                      .withValues(alpha: 0.1))
                                            ]),
                                        child: Text(
                                          '${bookStatusList[index].percent.floor()}%',
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: (pageViewIndex == 1)
                                                  ? Colors.white
                                                  : AppColors.black_59),
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
                                      bookStatusList[index].bookTitle,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          );
                        },
                      ),
                    ),
                  ));
  }

  Widget _bookshelfEmpty() {
    final pageViewIndex = ref.watch(bookshelfPageViewIndexProvider);
    final navIndex = ref.watch(currentIndexProvider);

    return EmptyBounce(
      key: ValueKey('$navIndex-$pageViewIndex'),
      child: Container(
        margin: EdgeInsets.only(top: 84.h),
        child: Column(
          children: [
            SizedBox(
              width: 200.r,
              height: 200.r,
              child: AppAssets.emptyBookshelf(pageViewIndex).image(),
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
                      : "나중에 읽고 싶은 책이 있다면\n책 추가하기에서 '읽고싶어요'를 눌러주세요",
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.grey_8D),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBar extends StatefulWidget {
  const _TabBar({
    required this.pageController,
    required this.currentIndex,
    required this.onTap,
  });

  final PageController pageController;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  State<_TabBar> createState() => _TabBarState();
}

class _TabBarState extends State<_TabBar> {
  double _page = 0;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _page = widget.pageController.page ?? widget.currentIndex.toDouble();
    });
  }

  static const _labels = ['읽고있어요', '다읽었어요', '읽고싶어요'];

  @override
  Widget build(BuildContext context) {
    final tabWidth = 98.w;
    final rowWidth = MediaQuery.of(context).size.width - 50.w;
    final gap = (rowWidth - tabWidth * 3) / 2;
    final indicatorLeft = _page * (tabWidth + gap);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      height: 36.h,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: AppColors.grey_F2, width: 1.w)),
      ),
      child: Stack(
        children: [
          Positioned(
            left: indicatorLeft,
            bottom: 0,
            child: Container(
              width: tabWidth,
              height: 2.h,
              color: AppColors.black_59,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              final isActive = widget.currentIndex == index;
              return GestureDetector(
                onTap: () => widget.onTap(index),
                child: Container(
                  alignment: Alignment.center,
                  width: tabWidth,
                  height: 36.h,
                  color: Colors.transparent,
                  child: Text(
                    _labels[index],
                    style: isActive
                        ? const TextStyle(
                            color: AppColors.black_59,
                            fontWeight: FontWeight.bold)
                        : const TextStyle(color: AppColors.grey_8D),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
