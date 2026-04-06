import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'package:book_flutter/core/ui/app_assets.dart';
import 'package:book_flutter/core/ui/app_colors.dart';
import 'package:book_flutter/core/ui/app_widgets.dart';
import 'package:book_flutter/features/book/presentation/providers/book_search_provider.dart';

class BookSearchPage extends ConsumerStatefulWidget {
  const BookSearchPage({super.key});

  @override
  ConsumerState<BookSearchPage> createState() => _BookSearchPageState();
}

class _BookSearchPageState extends ConsumerState<BookSearchPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late FToast fToast;

  String _query = '';
  int _currentPage = 1;
  bool _isLoading = false;
  bool _isSearch = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(bookSearchListProvider.notifier).reset();
      ref.read(bookTotalCountProvider.notifier).state = 0;
    });
    _scrollController.addListener(() {
      // 스크롤이 마지막에 도달했을 때 추가 데이터를 로드
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getSearchBook(_query);
      }
    });
    fToast = FToast();
    fToast.init(context);
  }

  //책 검색 api
  void getSearchBook(String query) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _isSearch = false;
    });

    final result = await ref
        .read(bookSearchRepositoryStateProvider)
        .searchBooks(query, _currentPage);

    if (result != null) {
      ref.read(bookTotalCountProvider.notifier).state = result.totalCount;

      if (result.items.isNotEmpty) {
        ref.read(bookSearchListProvider.notifier).addBookSearchList(
              result.items.cast(),
            );
        setState(() {
          _currentPage++;
        });
      }
    }

    setState(() {
      _isLoading = false;
      _isSearch = true;
    });
  }

  //책 상세조회 isbn api
  void getDetailBookIsbn(String isbn13) async {
    final statusCode = await ref
        .read(bookSearchRepositoryStateProvider)
        .fetchBookByIsbn(isbn13);
    if (!mounted) return;
    if (statusCode == 200) {
      context.pushNamed('book-add-garden', extra: {'isbn13': isbn13});
    } else if (statusCode == 401) {
      //500에러
    } else {
      Widgets.showToast(fToast, '바코드가 등록되지 않은 책이에요');
    }
  }

  Future<void> _scanBarcode() async {
    ref.read(barcodeValueProvider.notifier).state = '';

    try {
      final barcode = await context.pushNamed<String>('barcode-scan');

      if (barcode != null && barcode.isNotEmpty) {
        ref.read(barcodeValueProvider.notifier).state = barcode;
        getDetailBookIsbn(barcode);
      } else {
        if (!mounted) return;
        Widgets.showToast(fToast, '바코드가 인식되지 않았어요');
      }
    } catch (e) {
      debugPrint('바코드 스캔 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            margin: EdgeInsets.only(top: 20.h, bottom: 120.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 24.w),
                  child: Text(
                    '책 추가하기',
                    style:
                        TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      margin: EdgeInsets.only(
                          top: 20.h, left: 24.w, right: 24.w, bottom: 12.h),
                      alignment: Alignment.center,
                      height: 72.h,
                      child: TextField(
                        controller: _textEditingController,
                        onSubmitted: (value) {
                          _currentPage = 1;
                          _query = value;
                          ref.read(bookSearchListProvider.notifier).reset();
                          ref.read(bookTotalCountProvider.notifier).state = 0;
                          if (value.isNotEmpty) {
                            getSearchBook(value);
                          } else {
                            _isSearch = false;
                          }
                        },
                        style: TextStyle(fontSize: 16.sp),
                        decoration: InputDecoration(
                            prefixIcon: Container(
                              alignment: Alignment.center,
                              width: 20.r,
                              height: 20.r,
                              child: AppAssets.iconSearch.svg(
                                colorFilter: const ColorFilter.mode(
                                  AppColors.grey_8D,
                                  BlendMode.srcIn,
                                ),
                                width: 20.r,
                                height: 20.r,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10.r)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10.r)),
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10.r)),
                            fillColor: AppColors.grey_FA,
                            filled: true,
                            hintText: '제목, 작가 명으로 검색',
                            hintStyle: TextStyle(
                                fontSize: 16.sp, color: AppColors.grey_8D)),
                      )),
                ),
                (_isLoading && _currentPage == 1)
                    ? Container(
                        margin: EdgeInsets.only(top: 200.h),
                        child: const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: AppColors.primaryColor,
                            color: AppColors.grey_CA,
                          ),
                        ),
                      )
                    : (_isSearch && ref.watch(bookTotalCountProvider) == 0)
                        ? Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 200.h),
                            child: Column(
                              children: [
                                Text(
                                  '검색 결과를 찾지 못했어요',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.black_2B,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 6.h, bottom: 20.h),
                                  child: Text('책을 추가하려면 아래 기능을 이용해 보세요',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: AppColors.grey_8D)),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      context.pushNamed('book-user-write'),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 120.w,
                                    height: 36.h,
                                    decoration: BoxDecoration(
                                        color: AppColors.grey_EF,
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    child: Text(
                                      '책 직접 입력하기',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black_59),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : (ref.watch(bookSearchListProvider).isNotEmpty)
                            ? _serachList(_textEditingController.text)
                            : Column(
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        context.pushNamed('book-user-write'),
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: 72.h,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(
                                              left: 24.w, right: 22.w),
                                          width: 312.w,
                                          height: 64.h,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.grey_F2),
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              color: Colors.transparent),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '책 직접 입력하기',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              AppAssets.iconAngleRight.svg(
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  AppColors.grey_8D,
                                                  BlendMode.srcIn,
                                                ),
                                                width: 20.r,
                                                height: 20.r,
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: _scanBarcode,
                                    // onTap: () => context.pushNamed('book-barcode'),
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: 72.h,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(
                                              left: 24.w, right: 22.w),
                                          width: 312.w,
                                          height: 64.h,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.grey_F2),
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              color: Colors.transparent),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '바코드로 검색하기',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              AppAssets.iconAngleRight.svg(
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  AppColors.grey_8D,
                                                  BlendMode.srcIn,
                                                ),
                                                width: 20.r,
                                                height: 20.r,
                                              )
                                            ],
                                          ),
                                        )),
                                  )
                                ],
                              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _serachList(String value) {
    final bookSearchList = ref.watch(bookSearchListProvider);

    return SizedBox(
      height: (bookSearchList.length * 88.h) +
          42.h, //(itemcount * listcontainer) + titleContainer
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 22.h,
              margin: EdgeInsets.only(left: 24.w, top: 10.h, bottom: 10.h),
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: '\'$value\' ',
                    style: const TextStyle(color: AppColors.grey_8D)),
                TextSpan(
                    text: ref.watch(bookTotalCountProvider).toString(),
                    style: const TextStyle(color: AppColors.primaryColor))
              ]))),
          Expanded(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                bookSearchList.length,
                (index) {
                  return GestureDetector(
                    onTap: () => context.pushNamed('book-add-garden',
                        extra: {'isbn13': bookSearchList[index].isbn13}),
                    child: Container(
                      padding: EdgeInsets.only(left: 24.w, right: 24.w),
                      height: 88.h,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: CachedNetworkImage(
                              imageUrl: bookSearchList[index].cover,
                              width: 48.w,
                              height: 64.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 252.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  bookSearchList[index].title,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  bookSearchList[index].author,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.grey_8D,
                                      overflow: TextOverflow.ellipsis),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
