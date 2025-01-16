import 'dart:math';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
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
  final ScrollController _horiScrollController = ScrollController();

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
  late Stream<BranchResponse> stream;

  @override
  void initState() {
    super.initState();
    // Session 초기화
    initBranchSession();

    fToast = FToast();
    fToast.init(context);

    final gardenAPI = GardenAPI(ref);

    Future.microtask(() {
      // gardenAPI.resetGardenMain();
      gardenAPI.getGardenLsit();
    });
  }

  void initBranchSession() async {
    // FlutterBranchSdk.init().then((_) {
    //   // 앱 시작 시 Branch 링크 데이터 받기
    //   FlutterBranchSdk.getLatestReferringParams().then((params) {
    //     print("Received Branch params: $params");
    //   });
    // });

    // // 앱 실행 시 또는 백그라운드에서 복귀할 때 딥 링크 파라미터 처리
    // FlutterBranchSdk.getLatestReferringParams().then((params) {
    //   print("Branch referring params: $params");
    // });

    // // 앱 실행 후 딥 링크 파라미터를 받는 다른 방법
    // FlutterBranchSdk.getFirstReferringParams().then((params) {
    //   print("First referring params: $params");
    // });

    // // Branch SDK Session 시작
    FlutterBranchSdk.initSession().listen((data) {
      print('DeepLink Data: $data');
      if (data['+clicked_branch_link']) {
        context.pushNamed('invite', extra: int.parse(data['garden_no']));
      }
    }, onError: (error) {
      print('Error: $error');
    });
  }

  //꽃 퍼센트 분류
  int flowerPercent(double percent) {
    if (percent <= 32) {
      return 0;
    } else if (percent <= 65) {
      return 1;
    } else if (percent <= 99) {
      return 2;
    }
    return 3;
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
                _gardenMain(gardenAPI),
                GestureDetector(
                  onTap: () async {
                    _gardenMenuBottomSheet(gardenAPI);
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
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, 4),
                                          blurRadius: 16.r,
                                          color: AppColors.black_4A
                                              .withOpacity(0.01))
                                    ],
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
                                            '${Constant.ASSETS_ICONS}icon_angle_right.svg',
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
                                child: SvgPicture.asset(
                                  '${Constant.ASSETS_ICONS}icon_bookmark_full.svg',
                                  color: Functions.gardenColor(
                                      gardenAPI.gardenMain()['garden_color']),
                                  width: 20.w,
                                  height: 24.h,
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
                margin: EdgeInsets.only(bottom: 20.h),
                child: Stack(
                  // alignment: Alignment.centerLeft,

                  children: [
                    SvgPicture.asset('assets/images/image_add.svg'),
                    Container(
                      margin: EdgeInsets.only(left: 18.w, top: 10.h),
                      child: Text(
                        '💡   + 버튼으로 새로운 책을 등록해보세요!',
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _gardenMain(gardenAPI) {
    return TwoDimensionalScrollable(
      horizontalDetails: const ScrollableDetails.horizontal(),
      verticalDetails: const ScrollableDetails.vertical(),
      viewportBuilder: (context, verticalPosition, horizontalPosition) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _horiScrollController,
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
                          final result = await context.pushNamed('book-detail',
                              extra: gardenAPI.gardenMainBookList()[index]
                                  ['book_no']);
                          if (result != null) {
                            gardenAPI.getGardenLsit();
                          }
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Container(
                                width: 83.w,
                                height: 90.h,
                                color: Colors.amber,
                                child: Image.asset(
                                    '${Constant.MAIN_FLOWERS}${flowerPercent(gardenAPI.gardenMainBookList()[index]['percent'])}_${gardenAPI.gardenMainBookList()[index]['book_tree']}.png'),
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

  Future _gardenMenuBottomSheet(gardenAPI) {
    // final gardenAPI = GardenAPI(ref);
    gardenAPI.getGardenLsit();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.grey_F2,
      builder: (context) {
        return Container(
          height: 700.h,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
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
                                '${Constant.ASSETS_ICONS}icon_angle_right.svg',
                                color: AppColors.grey_8D,
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
                            alignment: Alignment.center,
                            width: 64.r,
                            height: 64.r,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: SvgPicture.asset(
                              '${Constant.ASSETS_ICONS}icon_photo.svg',
                              width: 28.r,
                              height: 28.r,
                            ),
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
                              alignment: Alignment.center,
                              width: 64.r,
                              height: 64.r,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: SvgPicture.asset(
                                '${Constant.ASSETS_ICONS}icon_edit.svg',
                                width: 28.r,
                                height: 28.r,
                              ),
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
                          Functions.shareBranchLink(
                              gardenAPI.gardenMain()['garden_title'],
                              gardenAPI.gardenMain()['garden_no']);
                          // Widgets.shareBottomSheet(
                          //     context,
                          //     '가든 공유하기',
                          //     gardenAPI.gardenMain()['garden_title'],
                          //     gardenAPI.gardenMain()['garden_no'],
                          //     fToast);
                        },
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 64.r,
                              height: 64.r,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: SvgPicture.asset(
                                '${Constant.ASSETS_ICONS}icon_share.svg',
                                width: 28.r,
                                height: 28.r,
                              ),
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
                            '${Constant.ASSETS_ICONS}icon_angle_right.svg',
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
          return GestureDetector(
            onTap: () {
              context.pushNamed('book-detail',
                  extra: gardenAPI.gardenMainBookList()[index]['book_no']);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.only(left: 14.w, right: 16.w),
              height: 68.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.white),
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
        physics: const BouncingScrollPhysics(),
        children: List.generate(
          gardenAPI.gardenList().length + 1,
          (index) {
            return (index != gardenAPI.gardenList().length)
                ? GestureDetector(
                    onTap: () {
                      gardenAPI.putGardenMain(
                          gardenAPI.gardenList()[index]['garden_no']);
                      context.pop();
                      _horiScrollController.animateTo(
                        0.0, // 스크롤 초기 위치
                        duration:
                            const Duration(milliseconds: 300), // 애니메이션 지속 시간
                        curve: Curves.easeOut, // 애니메이션 커브
                      );
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
                              '${Constant.ASSETS_ICONS}icon_bookmark.svg',
                              color: Functions.gardenColor(gardenAPI
                                  .gardenList()[index]['garden_color']),
                              width: 28.r,
                              height: 28.r,
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
                      context.pushNamed('garden-add');
                      // final result = await context.pushNamed('garden-add');
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
                            '${Constant.ASSETS_ICONS}icon_add.svg',
                            color: AppColors.grey_8D,
                            width: 28.r,
                            height: 28.r,
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
