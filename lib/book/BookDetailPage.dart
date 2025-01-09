import 'package:book_flutter/core/api/GardenAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../core/api/AuthAPI.dart';
import '../core/service/BookService.dart';
import '../core/service/GardenService.dart';
import '../core/provider/BookDetailNotifier.dart';
import '../core/service/MemoService.dart';
import '../garden/GardenEditPage.dart';
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Functions.dart';
import '../utils/Widgets.dart';

final bookDetailMemoListProvider = StateProvider<List>((ref) => []);
final bookDetailMemoSelectIndexListProvider = StateProvider<List>((ref) => []);
final bookDetailAppBarColorProvider =
    StateProvider<Color>((ref) => Colors.white);

class BookDetailPage extends ConsumerStatefulWidget {
  BookDetailPage({super.key, required this.book_no});

  _BookDetailPageState createState() => _BookDetailPageState();

  final int book_no;
}

class _BookDetailPageState extends ConsumerState<BookDetailPage> {
  final ScrollController _scrollController = ScrollController();
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    Future.microtask(() {
      ref.read(bookDetailProvider.notifier).reset();
      ref.read(bookDetailAppBarColorProvider.notifier).state = Colors.white;
      ref.read(bookDetailMemoListProvider.notifier).state = [];
      ref.read(bookDetailMemoSelectIndexListProvider.notifier).state = [];
    });
    _scrollController.addListener(() {
      if (_scrollController.offset > 580) {
        ref.read(bookDetailAppBarColorProvider.notifier).state = Colors.white;
      } else {
        ref.read(bookDetailAppBarColorProvider.notifier).state =
            Functions.gardenBackColor(
                ref.watch(bookDetailProvider)['garden_color']);
      }
    });
    getBookRead();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  //독서 기록 조회 api
  void getBookRead() async {
    final response = await bookService.getBookRead(widget.book_no);
    if (response?.statusCode == 200) {
      ref
          .read(bookDetailProvider.notifier)
          .updateBookDetail(response?.data['data']);

      ref.read(bookDetailMemoListProvider.notifier).state =
          response?.data['data']['memo_list'];

      for (var memo in ref.watch(bookDetailMemoListProvider)) {
        ref
            .read(bookDetailMemoSelectIndexListProvider.notifier)
            .state
            .add(memo['memo_like']);
      }
      getGardenDetial(response?.data['data']['garden_no']);

      // ref.read(bookDetailProvider.notifier).state = response?.data['data'];

      // ref.read(bookReadListProvider.notifier).state =
      //     response?.data['data']['book_read_list'];

      // if (ref.watch(bookReadListProvider).isNotEmpty) {
      //   //읽기 시작한 날
      //   _startController.text = Functions.formatBookReadDate(
      //       ref.watch(bookReadListProvider)[
      //           ref.watch(bookReadListProvider).length - 1]['book_start_date']);

      //   //다 읽은 날
      //   if (ref.watch(bookReadListProvider)[0]['book_end_date'] != null) {
      //     _endController.text = Functions.formatBookReadDate(
      //         ref.watch(bookReadListProvider)[0]['book_end_date']);
      //   }
    }
  }

  //가든 상세 조회 api
  void getGardenDetial(int garden_no) async {
    final response = await gardenService.getGardenDetail(garden_no);
    if (response?.statusCode == 200) {
      Map gardenDetail = {};
      gardenDetail['garden_title'] = response?.data['data']['garden_title'];
      gardenDetail['garden_color'] = response?.data['data']['garden_color'];
      ref.read(bookDetailProvider.notifier).updateGardenDetail(gardenDetail);
      ref.read(bookDetailAppBarColorProvider.notifier).state =
          Functions.gardenBackColor(gardenDetail['garden_color']);
    }
  }

  //책 수정 (가든 옮기기) api
  void putBook(to_garden_no) async {
    final data = {
      "garden_no": to_garden_no,
    };

    final response = await bookService.putBook(widget.book_no, data);
    if (response?.statusCode == 200) {
      context.pop();
      fToast.showToast(child: Widgets.toast('👌 선택한 가든으로 옮겨 심었어요'));
      getBookRead();
    } else if (response?.statusCode == 403) {
      fToast.showToast(child: Widgets.toast('😢 꽉 찼어요! 다른 가든을 선택해주세요'));
    }
  }

  //책 읽고싶어요 취소 (책 삭제)
  void deleteBook() async {
    final response = await bookService.deleteBook(widget.book_no);
    if (response?.statusCode == 200) {
      context.pop();
      context.pushNamed('bottom-navi');
    }
  }

  //메모 즐겨찾기 api
  void putMemoLike(int index, int id) async {
    final response = await memoService.putMemoLike(id);
    if (response?.statusCode == 200) {
      ref.read(bookDetailMemoSelectIndexListProvider.notifier).update((state) {
        List<bool> newState = List.from(state);
        newState[index] = !newState[index];
        return newState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authAPI = AuthAPI(ref);
    final bookDetail = ref.watch(bookDetailProvider);

    return Scaffold(
      backgroundColor: ref.watch(bookDetailAppBarColorProvider),
      appBar: Widgets.appBar(
        context,
        actions: [
          GestureDetector(
            onTap: _moreBottomSheet,
            child: Container(
              margin: EdgeInsets.only(right: 14.w),
              child: SvgPicture.asset('assets/images/angle-left-detail.svg',
                  width: 32.r, height: 32.r),
            ),
          )
        ],
        backFunction: () => context.pop('fetchData'),
        color: ref.watch(bookDetailAppBarColorProvider),
      ),
      body: Visibility(
        visible: bookDetail['garden_color'] != null,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            color: ref.watch(bookDetailAppBarColorProvider),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 24.w, right: 24.w, bottom: 40.h, top: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookDetail['book_title'] ?? '',
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: _borderContainer(
                                bookDetail['garden_title'] ?? ''),
                          ),
                          _borderContainer(Functions.bookStatusString(
                              bookDetail['book_status'] ?? 0)),
                        ],
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(top: 101.h),
                        child: Image.asset(
                          'assets/images/testImage.png',
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, -4),
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 16.r)
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r))),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 24.h, left: 40.w),
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '읽은 페이지',
                              style: TextStyle(
                                  fontSize: 12.sp, color: AppColors.grey_8D),
                            ),
                            Text.rich(TextSpan(
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600),
                                children: [
                                  TextSpan(
                                      text:
                                          '${bookDetail['book_current_page']}p '),
                                  TextSpan(
                                      text:
                                          '/ ${bookDetail['book_page'] ?? 0}p',
                                      style: const TextStyle(
                                          color: AppColors.grey_CA))
                                ]))
                          ],
                        ),
                      ),
                      Visibility(
                        visible:
                            bookDetail['user_no'] == authAPI.user()['user_no'],
                        child: GestureDetector(
                          onTap: () async {
                            bookDetail['book_no'] = widget.book_no;
                            final result = await context.pushNamed('book-add',
                                extra: bookDetail);
                            if (result != null) {
                              getBookRead();
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            // padding: EdgeInsets.only(
                            //     left: 16.w, right: 16.w, bottom: 8.h, top: 14.h),
                            margin: EdgeInsets.only(top: 20.h, right: 30.w),
                            width: 64.r,
                            height: 64.r,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.black_4A),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 19.35.h,
                                  width: 15.w,
                                  color: Colors.amber,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 2.65.h),
                                  height: 20.h,
                                  child: Text(
                                    '물주기',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.grey_FA),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 24.w, right: 24.w, top: 136.w, bottom: 53.h),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            (bookDetail['book_image_url'] == null)
                                ? Container(
                                    width: 122.w,
                                    height: 180.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: AppColors.grey_F2),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.network(
                                        width: 122.w,
                                        height: 180.h,
                                        fit: BoxFit.cover,
                                        bookDetail['book_image_url'] ?? ''),
                                  ),
                            Padding(
                              padding: EdgeInsets.only(top: 30.h, bottom: 8.h),
                              child: Text(
                                bookDetail['book_title'] ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18.sp),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                              child: Text(
                                bookDetail['book_author'] ?? '',
                                style: TextStyle(
                                    fontSize: 12.sp, color: AppColors.grey_8D),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2.h, bottom: 40.h),
                              height: 20.h,
                              child: Text(
                                bookDetail['book_publisher'] ?? '',
                                style: TextStyle(
                                    fontSize: 12.sp, color: AppColors.grey_8D),
                              ),
                            ),
                            bookDetail['user_no'] == authAPI.user()['user_no']
                                ? Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 24.w,
                                            right: 38.w,
                                            top: 20.h,
                                            bottom: 2.h),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 8.r,
                                                  color: const Color(0xff97CD8D)
                                                      .withOpacity(0.05))
                                            ],
                                            border: Border.all(
                                                color: AppColors.grey_F2),
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            color: Colors.white),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 18.h),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '히스토리',
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color:
                                                            AppColors.black_4A),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: (bookDetail[
                                                          'book_read_list'] !=
                                                      null)
                                                  ? (46.h + 18.h) *
                                                      bookDetail[
                                                              'book_read_list']
                                                          .length
                                                  : 0,
                                              child: (bookDetail[
                                                          'book_read_list'] !=
                                                      null)
                                                  ? ListView(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      children: List.generate(
                                                        bookDetail[
                                                                'book_read_list']
                                                            .length,
                                                        (index) {
                                                          return Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          18.h),
                                                              child:
                                                                  _bookReadListWidget(
                                                                      index));
                                                        },
                                                      ),
                                                    )
                                                  : Container(),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 40.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '메모',
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                Map data = bookDetail;
                                                data['book_no'] =
                                                    widget.book_no;
                                                final result = await context
                                                    .pushNamed('memo-write',
                                                        extra: bookDetail);

                                                if (result != null) {
                                                  getBookRead();
                                                }
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                child: const Text(
                                                  '+ 작성하기',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .primaryColor),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      _memoList()
                                    ],
                                  )
                                : Container(
                                    padding: EdgeInsets.only(
                                        left: 24.w,
                                        right: 24.w,
                                        top: 20.h,
                                        bottom: 20.h),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              offset: const Offset(0, 4),
                                              blurRadius: 8.r,
                                              color: const Color(0xff97CD8D)
                                                  .withOpacity(0.05))
                                        ],
                                        border: Border.all(
                                            color: AppColors.grey_F2),
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        color: Colors.white),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            '책 소개',
                                            style: TextStyle(
                                                color: AppColors.grey_8D),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.h),
                                            child: Text(
                                              bookDetail['book_info'] ?? '',
                                              style: TextStyle(fontSize: 12.sp),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _moreBottomSheet() {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          height: 260.h,
          child: Container(
            margin: EdgeInsets.only(top: 30.h, bottom: 30.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  color: Color(0xff97CDBD).withOpacity(0.05),
                  blurRadius: 8.r)
            ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    Map data = ref.watch(bookDetailProvider);
                    data['book_no'] = widget.book_no;

                    context.pop();
                    final response =
                        await context.pushNamed('book-edit', extra: data);
                    if (response != null) {
                      getBookRead();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 312.w,
                    // height: 24.h,
                    color: Colors.transparent,
                    child: Text(
                      '책 수정하기',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 24.h),
                  height: 1.h,
                  color: AppColors.grey_F2,
                ),
                GestureDetector(
                  onTap: () {
                    context.pop();
                    showModalBottomSheet(
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => GardenEditBottomSheet(
                              function: (int to_garden_no) {
                                putBook(to_garden_no);
                              },
                              gardenNo:
                                  ref.watch(bookDetailProvider)['garden_no'],
                            ));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 312.w,
                    // height: 24.h,
                    color: Colors.transparent,
                    child: Text(
                      '다른 가든으로 이전',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 24.h),
                  height: 1.h,
                  color: AppColors.grey_F2,
                ),
                GestureDetector(
                  onTap: () {
                    context.pop();
                    _bookDeleteBottomSheet();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 312.w,
                    // height: 24.h,
                    color: Colors.transparent,
                    child: Text(
                      '책 삭제하기',
                      style: TextStyle(
                          fontSize: 16.sp, color: AppColors.errorRedColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  //책 삭제하기 바텀시트
  Future _bookDeleteBottomSheet() {
    return Widgets.deleteBottomSheet(
        context,
        '이 책을 삭제할까요?',
        Text.rich(TextSpan(style: TextStyle(fontSize: 14.sp), children: const [
          TextSpan(text: '책을 삭제하면 내가 기록한 '),
          TextSpan(
              text: '독서 기록', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '과 '),
          TextSpan(text: '메모', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '도 모두 삭제되어요.'),
        ])),
        '삭제하기',
        deleteBook);
  }

  Widget _borderContainer(String title) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.black_4A),
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.transparent),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black_4A),
      ),
    );
  }

  //독서 기록 리스트 index별 형식
  Widget _bookReadListWidget(int index) {
    final bookDetail = ref.watch(bookDetailProvider);

    //맨 위(독서 끝)
    return (index == 0 &&
            bookDetail['book_read_list'][index]['book_end_date'] != null)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: bookDetail['book_tree'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const TextSpan(text: '가 다컸어요')
              ])),
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  Functions.formatDate(bookDetail['book_read_list'][index]
                          ['book_end_date'] ??
                      DateTime.now().toString()),
                  style: TextStyle(fontSize: 12.sp, color: AppColors.grey_8D),
                ),
              )
            ],
          )
        //맨 아래(독서 시작)
        : (index == bookDetail['book_read_list'].length - 1)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(children: [
                    const TextSpan(text: '새로운 꽃 '),
                    TextSpan(
                        text: bookDetail['book_tree'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: '를 심었어요')
                  ])),
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      Functions.formatDate(bookDetail['book_read_list'][index]
                              ['book_start_date'] ??
                          DateTime.now().toString()),
                      style:
                          TextStyle(fontSize: 12.sp, color: AppColors.grey_8D),
                    ),
                  )
                ],
              )
            //중간 기록
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text:
                          '${bookDetail['book_read_list'][index]['book_current_page'] ?? '0'}p',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' 만큼 물을 주었어요')
                ])),
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    Functions.formatDate(bookDetail['book_read_list'][index]
                            ['book_created_at'] ??
                        DateTime.now().toString()),
                    style: TextStyle(fontSize: 12.sp, color: AppColors.grey_8D),
                  ),
                )
              ]);
  }

  //메모 리스트
  Widget _memoList() {
    final bookDetail = ref.watch(bookDetailProvider);
    final memoList = ref.watch(bookDetailMemoListProvider);
    // if (bookDetail['memo_list'] != null) {
    //   memoList = bookDetail['memo_list'];
    // }

    return (memoList.isNotEmpty)
        ? ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 20.h),
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              memoList.length,
              (index) {
                return GestureDetector(
                  onTap: () async {
                    Map data = memoList[index];
                    data['book_no'] = widget.book_no;
                    data['book_title'] = bookDetail['book_title'];
                    data['book_author'] = bookDetail['book_author'];
                    data['book_image_url'] = bookDetail['book_image_url'];

                    final result =
                        await context.pushNamed('memo-detail', extra: data);
                    if (result != null) {
                      getBookRead();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    padding: EdgeInsets.only(
                        left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
                    width: 312.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey_F2),
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.transparent),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            (bookDetail['book_image_url'] == null)
                                ? Container(
                                    width: 44.r,
                                    height: 44.r,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: AppColors.grey_F2),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.network(
                                      width: 44.r,
                                      height: 44.r,
                                      fit: BoxFit.cover,
                                      bookDetail['book_image_url'],
                                    ),
                                  ),
                            Container(
                              width: 212.w,
                              margin: EdgeInsets.only(left: 12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bookDetail['book_title'] ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    bookDetail['book_author'] ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.grey_8D),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Visibility(
                            visible: (memoList[index]['image_url'] != null),
                            child: Container(
                              margin: EdgeInsets.only(top: 10.h),
                              child: Image.network(
                                  width: 320.w,
                                  height: 140.h,
                                  fit: BoxFit.fitWidth,
                                  '${Constant.IMAGE_URL}${memoList[index]['image_url']}'),
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 10.h),
                            child: Text(
                              memoList[index]['memo_content'],
                              maxLines: 5,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  overflow: TextOverflow.ellipsis),
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 10.h),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Functions.formatDate(
                                        memoList[index]['memo_created_at']),
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.grey_8D),
                                  ),
                                  (ref
                                          .watch(
                                              bookDetailMemoSelectIndexListProvider)
                                          .isNotEmpty)
                                      ? GestureDetector(
                                          onTap: () => putMemoLike(
                                              index, memoList[index]['id']),
                                          child: SvgPicture.asset(
                                            ref.watch(bookDetailMemoSelectIndexListProvider)[
                                                    index]
                                                ? 'assets/images/star.svg'
                                                : 'assets/images/star-dis.svg',
                                            width: 20.r,
                                            height: 20.r,
                                          ),
                                        )
                                      : Container()
                                ])),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : Container(
            margin: EdgeInsets.only(top: 40.h, bottom: 40.h),
            child: const Text(
              '책을 읽고 마음에 드는 문구나 생각들을\n모두 모아 적어주세요',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.grey_8D),
            ),
          );
  }
}
