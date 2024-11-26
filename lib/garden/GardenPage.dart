import 'dart:math';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../core/api/GardenAPI.dart';
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Functions.dart';
import '../utils/Widgets.dart';

class GardenPage extends ConsumerStatefulWidget {
  @override
  _GardenPageState createState() => _GardenPageState();
}

class _GardenPageState extends ConsumerState<GardenPage> {
  final AppLinks _appLinks = AppLinks();
  String _linkMessage = 'No link received yet';

  //배경 이미지 초기 오프셋
  // Offset _backgroundOffset = Offset.zero;
  //텍스트 위치 리스트
  // List<Offset> _textPositions = [];
  // late Future<int> _countFuture;

  // final Random _random = Random();
  // Offset _position = Offset.zero;
  // final double widgetWidth = 150.0;
  // final double widgetHeight = 200.0;
  // late List<Offset> _textPositions;

  late FToast fToast;

  @override
  void initState() {
    super.initState();

    _initAppLinks();

    fToast = FToast();
    fToast.init(context);

    final gardenAPI = GardenAPI(ref);

    Future.microtask(() {
      // gardenAPI.resetGardenMain();
      gardenAPI.getGardenLsit();
    });
  }

  //딥링크 열기
  Future<void> _initAppLinks() async {
    try {
      // 앱이 처음 실행될 때 초기 딥링크 URI를 가져옴
      final Uri? initialUri = await _appLinks.getInitialLink();
      print(initialUri);

      if (initialUri != null) {
        // 딥링크로 앱이 열렸을 때 처리
        _handleDeepLink(initialUri.toString());
      }
    } catch (e) {
      print("Error initializing app links: $e");
    }
  }

  //딥링크 처리
  void _handleDeepLink(String url) {
    final Uri uri = Uri.parse(url);
    if (uri.scheme == 'myapp' && uri.host == 'invite') {
      final String garden_no = uri.pathSegments[0]; // garden_no 추출
      print(uri.scheme);
      print(url);

      if (mounted) {
        setState(() {
          _linkMessage = 'Received garden_no: $garden_no';
          print(_linkMessage);
        });

        context.goNamed('invite', extra: int.parse(garden_no));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final gardenAPI = GardenAPI(ref);

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            color: Colors.green,
            child: Stack(
              children: [
                _gardenMain(),
                GestureDetector(
                  onTap: () async {
                    _gardenMenuBottomSheet();
                  },
                  child: (gardenAPI.gardenMain().isNotEmpty)
                      ? Container(
                          margin: EdgeInsets.only(
                              top: 80.h, left: 24.w, right: 24.w),
                          color: Colors.transparent,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 14.h),
                                width: 312.w,
                                height: 86.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.r)),
                                child: SizedBox(
                                  height: 48.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            gardenAPI
                                                .gardenMain()['garden_title'],
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                            'assets/images/garden-angle-right-b.svg',
                                            width: 20.r,
                                            height: 20.r,
                                          )
                                        ],
                                      ),
                                      Text(
                                        gardenAPI.gardenMain()['garden_info'],
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColors.grey_8D,
                                            overflow: TextOverflow.ellipsis),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20.w),
                                width: 20.w,
                                height: 30.h,
                                child: SvgPicture.asset(
                                  'assets/images/garden-color.svg',
                                  color: Functions.gardenColor(
                                      gardenAPI.gardenMain()['garden_color']),
                                  width: 20.w,
                                  height: 30.h,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
          Visibility(
            visible: gardenAPI.gardenMainBookList().isEmpty,
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 20.h),
              padding: EdgeInsets.only(left: 18.w),
              width: 312.w,
              height: 40.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.black_4A),
              child: Text(
                '💡   + 버튼으로 새로운 책을 등록해보세요!',
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gardenMain() {
    final gardenAPI = GardenAPI(ref);

    return TwoDimensionalScrollable(
      horizontalDetails: const ScrollableDetails.horizontal(),
      verticalDetails: const ScrollableDetails.vertical(),
      viewportBuilder: (context, verticalPosition, horizontalPosition) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  width: constraints.maxWidth * 1.7, // 가로 스크롤을 위해 넓게 설정
                  height: constraints.maxHeight, // 세로 스크롤을 위해 길게 설정
                  child: GridView.builder(
                    padding: EdgeInsets.only(
                        top: 200.h, left: 42.w, right: 42.w, bottom: 200.h),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 126.h, //세로 길이
                      mainAxisSpacing: 30.h, //세로 패딩
                      crossAxisSpacing: 24.w, //가로 패딩
                      crossAxisCount: 5,
                    ),
                    itemCount: gardenAPI.gardenMainBookList().length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          print(gardenAPI.gardenMainBookList()[index]);
                          final result = await context.pushNamed('book-detail',
                              extra: gardenAPI.gardenMainBookList()[index]
                                  ['book_no']);
                          if (result != null) {}
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Container(
                                width: 83.w,
                                height: 90.h,
                                color: Colors.amber,
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 8.h),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 2.h),
                                  height: 28.h,
                                  decoration: BoxDecoration(
                                      color: AppColors.grey_F2,
                                      border: Border.all(
                                          width: 1.w,
                                          color: AppColors.black_4A),
                                      borderRadius:
                                          BorderRadius.circular(20.r)),
                                  child: Text(
                                    gardenAPI.gardenMainBookList()[index]
                                        ["book_title"],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600),
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future _gardenMenuBottomSheet() {
    final gardenAPI = GardenAPI(ref);
    gardenAPI.getGardenLsit();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.grey_F2,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                left: 24.w, right: 24.w, top: 38.h, bottom: 54.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _gardenList(),
                Container(
                  margin: EdgeInsets.only(top: 16.h, bottom: 8.h),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                            top: 56.h, left: 20.w, right: 20.w, bottom: 20.h),
                        height: 200.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              gardenAPI.gardenMain()['garden_info'],
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold),
                            ),
                            _gardenProgress()
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20.w),
                        height: 36.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r)),
                            color: Functions.gardenColor(
                                gardenAPI.gardenMain()['garden_color'])),
                        child: Text(
                          gardenAPI.gardenMain()['garden_title'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.pop();
                    context.pushNamed('garden-member',
                        extra: gardenAPI.gardenMain()['garden_no']);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.only(left: 20.w, right: 16.w),
                    height: 56.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '가든 멤버 보기',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            _memberProfile(),
                            SvgPicture.asset(
                              'assets/images/garden-angle-right-b.svg',
                              width: 20.r,
                              height: 20.r,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 64.r,
                          height: 64.r,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 8.h),
                          child: Text(
                            '사진찍기',
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed('garden-edit');
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 64.r,
                            height: 64.r,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 8.h),
                            child: Text(
                              '수정하기',
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                        Widgets.shareBottomSheet(
                            context,
                            '가든 공유하기',
                            gardenAPI.gardenMain()['garden_title'],
                            gardenAPI.gardenMain()['garden_no'],
                            fToast);
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 64.r,
                            height: 64.r,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 8.h),
                            child: Text(
                              '공유하기',
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    context.pushNamed('garden-book',
                        extra: gardenAPI.gardenMain());
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 30.h),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '가든에 있는 책 보기',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        SvgPicture.asset(
                          'assets/images/garden-angle-right-b.svg',
                          width: 20.r,
                          height: 20.r,
                        )
                      ],
                    ),
                  ),
                ),
                (gardenAPI.gardenMainBookList().isEmpty)
                    ? _bookEmpty()
                    : _bookList()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _bookList() {
    final gardenAPI = GardenAPI(ref);

    return ListView(
      padding: EdgeInsets.only(top: 12.h),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        gardenAPI.gardenMainBookList().length > 3
            ? 3
            : gardenAPI.gardenMainBookList().length,
        (index) {
          return Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.only(left: 14.w, right: 16.w),
            height: 68.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r), color: Colors.white),
            child: Row(
              children: [
                (gardenAPI.gardenMainBookList()[index]['book_image_url'] !=
                        null)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                            width: 44.r,
                            height: 44.r,
                            fit: BoxFit.fitWidth,
                            gardenAPI.gardenMainBookList()[index]
                                ['book_image_url']),
                      )
                    : Container(
                        width: 44.r,
                        height: 44.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.grey_F2,
                        ),
                      ),
                Container(
                  margin: EdgeInsets.only(left: 12.w),
                  width: 226.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        gardenAPI.gardenMainBookList()[index]['book_title'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        gardenAPI.gardenMainBookList()[index]['book_author'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12.sp, color: AppColors.grey_8D),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  //가든 멤버 보기
  Widget _memberProfile() {
    final gardenAPI = GardenAPI(ref);
    final memberCount = gardenAPI.gardenMain()['garden_members'].length;

    return Container(
      margin: EdgeInsets.only(right: 4.w),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.green),
          ),
          Visibility(
            visible: memberCount >= 2,
            child: SizedBox(
              width: 32.r * 2,
              child: Container(
                width: 32.r,
                height: 32.r,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
              ),
            ),
          ),
          Visibility(
            visible: false,
            child: SizedBox(
              width: 100.w,
              child: Container(
                width: 32.r,
                height: 32.r,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black),
              ),
            ),
          ),
          Visibility(
            visible: false,
            child: SizedBox(
              width: 140.w,
              child: Container(
                width: 32.r,
                height: 32.r,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.amber),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookEmpty() {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 40.h),
        child: const Text(
          '지금 읽고 있는 책이 있나요?\n책을 추가하고 가든을 가꿔보세요',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.grey_8D),
        ));
  }

  Widget _gardenList() {
    final gardenAPI = GardenAPI(ref);

    return SizedBox(
      height: 72.h,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: List.generate(
          gardenAPI.gardenList().length + 1,
          (index) {
            return (index != gardenAPI.gardenList().length)
                ? GestureDetector(
                    onTap: () {
                      gardenAPI.putGardenMain(
                          gardenAPI.gardenList()[index]['garden_no']);
                      context.pop();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 12.w),
                      width: 52.w,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 52.r,
                            height: 52.r,
                            decoration: BoxDecoration(
                                border: (gardenAPI.gardenList()[index]
                                            ['garden_no'] ==
                                        gardenAPI.gardenMain()['garden_no'])
                                    ? Border.all(
                                        width: 1.w, color: AppColors.black_4A)
                                    : null,
                                shape: BoxShape.circle,
                                color: Colors.white),
                            child: SvgPicture.asset(
                              'assets/images/garden-color.svg',
                              color: Functions.gardenColor(gardenAPI
                                  .gardenList()[index]['garden_color']),
                              width: 20.w,
                              height: 30.h,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 2.h),
                            height: 18.h,
                            child: Text(
                              gardenAPI.gardenList()[index]['garden_title'],
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: (gardenAPI.gardenList()[index]
                                              ['garden_no'] ==
                                          gardenAPI.gardenMain()['garden_no'])
                                      ? Colors.black
                                      : AppColors.grey_8D,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      context.pop();
                      final result = await context.pushNamed('garden-add');
                      // if (result != null) {
                      //   //TODO: - result를 담기
                      //   getGardenDetail(20);
                      // }
                    },
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 52.r,
                          height: 52.r,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: SvgPicture.asset(
                            'assets/images/garden-plus.svg',
                            width: 24.r,
                            height: 24.r,
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget _gardenProgress() {
    final gardenAPI = GardenAPI(ref);
    int bookCount = gardenAPI.gardenMainBookList().length;

    double progress = bookCount / 30;

    return (bookCount < 30)
        ? Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 272.w,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '가든을 다 채울때까지 앞으로 ${30 - bookCount}권',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    Text(
                      '$bookCount/30',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 6.h),
                      height: 8.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(500.r),
                        color: AppColors.grey_F2,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6.h),
                      width: progress * 272.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(500.r),
                        color: Colors.black,
                      ),
                    )
                  ],
                )
              ],
            ))
        : Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 272.w,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('가든을 다 채웠어요!'),
                    Text(
                      '30/30',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 6.h),
                  height: 8.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500.r),
                    color: Colors.black,
                  ),
                )
              ],
            ));
  }
}
