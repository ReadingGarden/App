import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
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
  //배경 이미지 초기 오프셋
  Offset _backgroundOffset = Offset.zero;
  //텍스트 위치 리스트
  // List<Offset> _textPositions = [];
  late Future<int> _countFuture;

  final Random _random = Random();
  Offset _position = Offset.zero;
  final double widgetWidth = 150.0;
  final double widgetHeight = 200.0;
  late List<Offset> _textPositions;

  @override
  void initState() {
    super.initState();

    final gardenAPI = GardenAPI(ref);

    Future.microtask(() {
      gardenAPI.resetGardenMain();
      gardenAPI.getGardenLsit();
      //화면에 텍스트 위치 6개를 랜덤하게 배치
      // _generateRandomPositions(3);
      Future.delayed(Duration(seconds: 1), () {
        _textPositions = _generateGridPositions();
        // _textPositions = _generateUniquePositions();
      });
    });
  }

  // //텍스트의 랜덤 위치를 생성
  // void _generateRandomPositions(int count) {
  //   //화면 크기 가져오기
  //   final screenSize = MediaQuery.of(context).size;

  //   setState(() {
  //     _textPositions = List.generate(count, (index) {
  //       return Offset(
  //         //x,y좌표 랜덤 생성
  //         //일반적으로 무작위 좌표가 화면의 가장자리와 겹치지 않도록 하는 오프셋 또는 여백
  //         _random.nextDouble() * (screenSize.width - 100),
  //         _random.nextDouble() * (screenSize.height - 200),
  //       );
  //     });
  //   });
  // }

  List<Offset> _generateGridPositions() {
    // final gardenAPI = GardenAPI();
    final count = 6; // 생성할 위젯의 수
    final screenSize = MediaQuery.of(context).size;

    // final int columns = (screenSize.width / (widgetWidth * 1.1)).floor();
    final int columns = 3;
    final int rows = 2;
    // final int rows = (count / columns).ceil();

    final double horizontalSpacing =
        (screenSize.width - (columns * widgetWidth)) / (columns + 1);
    final double verticalSpacing =
        (screenSize.height - (rows * widgetHeight)) / (rows + 1);

    List<Offset> positions = [];

    for (int i = 0; i < count; i++) {
      int row = i ~/ columns;
      int column = i % columns;
      double x = horizontalSpacing + (widgetWidth + horizontalSpacing) * column;
      double y = verticalSpacing + (widgetHeight + verticalSpacing) * row;
      positions.add(Offset(x, y));
    }

    return positions;
  }

  // List<Offset> _generateUniquePositions() {
  //   final gardenAPI = GardenAPI(ref);
  //   print(gardenAPI.gardenMain());

  //   final count = gardenAPI.gardenMainBookList().length; // 생성할 위젯의 수

  //   final screenSize = MediaQuery.of(context).size;

  //   final List<Offset> positions = [];

  //   final double widgetWidth = 150.0;
  //   final double widgetHeight = 200.0;

  //   double widgetWidth2 = 0;
  //   double widgetHeight2 = 0;

  //   for (int i = 0; i < count; i++) {
  //     Offset newOffset;
  //     bool isColliding;

  //     do {
  //       isColliding = false;
  //       newOffset = Offset(
  //         // _random.nextDouble() * (screenSize.width - widgetWidth),
  //         // _random.nextDouble() * (screenSize.height - widgetHeight),
  //         widgetWidth2 * (screenSize.width - widgetWidth),
  //         widgetHeight2 * (screenSize.height - widgetHeight),
  //       );

  //       // 충돌 감지
  //       for (var pos in positions) {
  //         if ((newOffset.dx < pos.dx + widgetWidth &&
  //             newOffset.dx + widgetWidth > pos.dx &&
  //             newOffset.dy < pos.dy + widgetHeight &&
  //             newOffset.dy + widgetHeight > pos.dy)) {
  //           isColliding = true;
  //           break;
  //         }
  //       }
  //     } while (isColliding);

  //     positions.add(newOffset);
  //   }

  //   widgetWidth2 += 0.1;
  //   widgetHeight2 += 0.1;

  //   return positions;
  // }

  //드래그 업데이트
  void _onPanUpdate(DragUpdateDetails details) {
    //화면 크기 가져오기
    final screenSize = MediaQuery.of(context).size;

    setState(() {
      // 새로운 오프셋 계산
      Offset newOffset = _backgroundOffset + details.delta;
      // print(MediaQuery.of(context).size.width);

      // 드래그 제한
      double minX = -screenSize.width; // 최솟값 (왼쪽으로 이동 제한)
      double maxX = screenSize.width; // 최댓값 (오른쪽으로 이동 제한)
      double minY = -screenSize.height; // 최솟값 (위쪽으로 이동 제한)
      double maxY = screenSize.height; // 최댓값 (아래쪽으로 이동 제한)

      _backgroundOffset = Offset(
        newOffset.dx.clamp(minX, maxX),
        newOffset.dy.clamp(minY, maxY),
      );
      _position = details.globalPosition;
    });

    // setState(() {
    //   //배경 오프셋을 드래그한 만큼 이동
    //   _backgroundOffset += details.delta;

    //   _position = details.globalPosition;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final gardenAPI = GardenAPI(ref);

    return Scaffold(
      body: GestureDetector(
        //드래그 이벤트 처리
        onPanUpdate: _onPanUpdate,
        onTap: () => context.pushNamed('book-detail'),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              // width: 300,
              // height: 300,
              width: MediaQuery.of(context).size.width * 2,
              height: MediaQuery.of(context).size.height * 2,
              color: Constant.GARDEN_CHIP_COLOR_SET_LIST[3],
              child: Stack(
                children: [
                  OverflowBox(
                    maxWidth: MediaQuery.of(context).size.width + 100,
                    maxHeight: MediaQuery.of(context).size.height + 200,
                    child: Transform.translate(
                      //배경을 이동시킬 오프셋
                      offset: _backgroundOffset,
                      child: Stack(
                          // children: _textPositions.map((position) {
                          //   return Positioned(
                          //     left: position.dx,
                          //     top: position.dy,
                          //     child: Column(
                          //       children: [
                          //         SvgPicture.asset(
                          //           'assets/images/star.svg',
                          //           width: 112.w,
                          //           height: 160.h,
                          //         ),
                          //         Container(
                          //           padding: EdgeInsets.symmetric(
                          //               vertical: 4, horizontal: 8),
                          //           decoration: BoxDecoration(
                          //             color: Colors.pink.shade100,
                          //             borderRadius: BorderRadius.circular(10),
                          //           ),
                          //           child: Text(
                          //             '이름을 입력해주세요',
                          //             style: TextStyle(color: Colors.black),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   );
                          // }).toList(),
                          ),
                    ),
                  ),
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
                                  height: 76.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(20.r)),
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
            Text(
              '터치 좌표\nX: ${_position.dx.toStringAsFixed(2)}\nY: ${_position.dy.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future _gardenMenuBottomSheet() {
    final gardenAPI = GardenAPI(ref);

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
                        height: 180.h,
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
                          height: 18.h,
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
                            height: 18.h,
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
                        Widgets.shareBottomSheet(context, '가든 공유하기');
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
                            height: 18.h,
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
                    height: 24.h,
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
                  height: 42.h,
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
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
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
                          )
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
                    Text('가든을 다 채울때까지 앞으로 ${30 - bookCount}권'),
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
