import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import 'package:book_flutter/app/navigation/bottom_navi_page.dart';
import 'package:book_flutter/core/common/functions.dart';
import 'package:book_flutter/core/ui/app_assets.dart';
import 'package:book_flutter/core/ui/app_colors.dart';
import 'package:book_flutter/core/ui/app_widgets.dart';
import 'package:book_flutter/gen/assets.gen.dart';
import 'package:book_flutter/features/garden/domain/entities/garden_main_entity.dart';
import 'package:book_flutter/features/garden/presentation/providers/garden_provider.dart'
    as garden_feature;

class GardenPage extends ConsumerStatefulWidget {
  const GardenPage({super.key});

  @override
  ConsumerState<GardenPage> createState() => _GardenPageState();
}

class _GardenPageState extends ConsumerState<GardenPage>
    with SingleTickerProviderStateMixin {
  // 스크롤 가능한 영역을 위한 GlobalKey
  final GlobalKey _scrollViewKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final ScreenshotController screenshotController = ScreenshotController();

  late FToast fToast;
  late Stream<BranchResponse> stream;
  bool _showFlash = false;
  late AnimationController _flowerAnimController;
  int _prevBookCount = 0;
  int _prevNavIndex = -1;
  int _prevGardenNo = -1;
  int _prevVisitCount = -1;

  @override
  void initState() {
    super.initState();
    _flowerAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Session 초기화
    initBranchSession();

    fToast = FToast();
    fToast.init(context);

    Future.microtask(() {
      garden_feature.fetchGardenList(ref);
    });
  }

  @override
  void dispose() {
    _flowerAnimController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void initBranchSession() async {
    FlutterBranchSdk.listSession().listen((data) {
      debugPrint('브랜치 딥링크 데이터 수신: $data');
      if (!mounted) return;
      if (data['+clicked_branch_link']) {
        context.pushNamed('invite', extra: int.parse(data['garden_no']));
      }
    }, onError: (error) {
      debugPrint('브랜치 딥링크 처리 실패: $error');
    });
  }

  //꽃 퍼센트 분류
  int flowerPercent(double percent) {
    if (percent <= 32) {
      return 1;
    } else if (percent <= 65) {
      return 2;
    } else if (percent <= 99) {
      return 3;
    }
    return 4;
  }

  // 현재 화면 높이 + 스크롤된 거리
  double getTotalScrollHeight(int bookCount) {
    if (bookCount <= 9) {
      return 530.h;
    } else {
      // print('----------------------------------------');
      // print((bookCount - 9));
      // print(((bookCount - 9) / 3).ceil());
      return 530.h + ((bookCount - 9) / 3).ceil() * (160.h);
    }
  }

  // 화면 스크린샷
  void _captureScreenshot() {
    context.pop();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      // 플래시 효과: fade in 150ms → 유지 300ms → fade out 400ms
      setState(() => _showFlash = true);
      await Future.delayed(const Duration(milliseconds: 450));
      if (!mounted) return;
      setState(() => _showFlash = false);

      try {
        RenderRepaintBoundary? boundary = _scrollViewKey.currentContext
            ?.findRenderObject() as RenderRepaintBoundary?;

        if (boundary != null) {
          var image = await boundary.toImage(pixelRatio: 3.0);
          ByteData? byteData =
              await image.toByteData(format: ImageByteFormat.png);
          Uint8List uint8List = byteData!.buffer.asUint8List();

          final directory = await getApplicationDocumentsDirectory();
          final path = '${directory.path}/garden.png';
          final file = File(path);
          await file.writeAsBytes(uint8List);

          GallerySaver.saveImage(path);
        }
      } catch (e) {
        debugPrint('가든 스크린샷 캡처 중 오류: $e');
      }

      if (!mounted) return;
      fToast.init(context);
      Widgets.showToast(fToast, '갤러리에 사진이 저장되었어요!');
    });
  }

  @override
  Widget build(BuildContext context) {
    final gardenMain = ref.watch(garden_feature.gardenMainProvider);
    final gardenMainBookList =
        ref.watch(garden_feature.gardenMainBookListProvider);
    final navIndex = ref.watch(currentIndexProvider);
    final visitCount = ref.watch(garden_feature.gardenVisitCountProvider);

    if (gardenMainBookList.isNotEmpty &&
        (gardenMainBookList.length != _prevBookCount ||
            navIndex != _prevNavIndex ||
            gardenMain.gardenNo != _prevGardenNo ||
            visitCount != _prevVisitCount)) {
      _prevBookCount = gardenMainBookList.length;
      _prevNavIndex = navIndex;
      _prevGardenNo = gardenMain.gardenNo;
      _prevVisitCount = visitCount;
      _flowerAnimController.forward(from: 0);
    }

    return Scaffold(
      body: Stack(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Stack(
              alignment: Alignment.bottomCenter,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                _gardenMain(gardenMainBookList),
                GestureDetector(
                  onTap: () async {
                    _gardenMenuBottomSheet();
                  },
                  child: (!gardenMain.isEmpty)
                      ? Container(
                          margin: EdgeInsets.only(
                              top: 34.h, left: 24.w, right: 24.w),
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
                                          color: AppColors.black_59
                                              .withValues(alpha: 0.3))
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.r)),
                                child: SizedBox(
                                  height: 48.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            gardenMain.gardenTitle,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          AppAssets.iconAngleRight.svg(
                                            width: 20.r,
                                            height: 20.r,
                                          )
                                        ],
                                      ),
                                      Text(
                                        gardenMain.gardenInfo,
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
                                child: AppAssets.iconBookmarkFull.svg(
                                  colorFilter: ColorFilter.mode(
                                    Functions.gardenColor(
                                        gardenMain.gardenColor),
                                    BlendMode.srcIn,
                                  ),
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
            if (gardenMainBookList.isEmpty && !gardenMain.isEmpty)
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _FloatingBalloon(),
              ),
          ],
        ),
      ),
      IgnorePointer(
        child: AnimatedOpacity(
          opacity: _showFlash ? 1.0 : 0.0,
          duration: Duration(milliseconds: _showFlash ? 150 : 400),
          child: Container(color: Colors.white),
        ),
      ),
      ],
      ),
    );
  }

  Widget _gardenMain(gardenMainBookList) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: RepaintBoundary(
        key: _scrollViewKey,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                Assets.images.mainTopBack
                    .image(width: 360.w, height: 200.5.w, fit: BoxFit.fitWidth),
                Assets.images.mainBottomBack.image(
                  fit: BoxFit.cover,
                  width: 360.w,
                  height: getTotalScrollHeight(gardenMainBookList.length),
                ),
              ],
            ),
            GridView.builder(
              padding: EdgeInsets.only(
                top: 210.h,
                left: 20.w,
                right: 20.w,
              ),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 130.h, //세로 길이
                mainAxisSpacing: 30.h, //세로 패딩
                crossAxisSpacing: 8.w, //가로 패딩
                crossAxisCount: 3,
              ),
              itemCount: gardenMainBookList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final book = gardenMainBookList[index];
                final delay = (index * 0.06).clamp(0.0, 0.7);
                final end = (delay + 0.3).clamp(0.0, 1.0);
                final animation = CurvedAnimation(
                  parent: _flowerAnimController,
                  curve: Interval(delay, end, curve: Curves.easeOut),
                );
                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: animation.value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - animation.value)),
                        child: child,
                      ),
                    );
                  },
                  child: GestureDetector(
                    onTap: () async {
                      final result = await context.pushNamed('book-detail',
                          extra: book.bookNo);
                      if (result != null) {
                        garden_feature.fetchGardenList(ref);
                      }
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 83.w,
                            height: 90.h,
                            child: AppAssets.mainFlower(
                              flowerPercent(book.percent),
                              book.bookTree,
                            ).image(),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 8.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                  color: AppColors.grey_F2,
                                  border: Border.all(
                                      width: 1.w, color: AppColors.black_59),
                                  borderRadius: BorderRadius.circular(20.r)),
                              child: Text(
                                book.bookTitle,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future _gardenMenuBottomSheet() {
    final gardenMain = ref.read(garden_feature.gardenMainProvider);
    final gardenMainBookList =
        ref.read(garden_feature.gardenMainBookListProvider);
    garden_feature.fetchGardenList(ref);

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.grey_F2,
      builder: (context) {
        return _GardenMenuSheet(
          gardenMain: gardenMain,
          gardenMainBookList: gardenMainBookList,
          gardenListWidget: _gardenList(),
          memberProfileWidget: _memberProfile(),
          gardenProgressWidget: _gardenProgress(),
          bookListWidget:
              gardenMainBookList.isEmpty ? _bookEmpty() : _bookList(),
          onCapture: _captureScreenshot,
          scrollController: _scrollController,
        );
      },
    );
  }

  Widget _bookList() {
    final gardenMainBookList =
        ref.watch(garden_feature.gardenMainBookListProvider);

    return ListView(
      padding: EdgeInsets.only(top: 12.h),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        gardenMainBookList.length > 3 ? 3 : gardenMainBookList.length,
        (index) {
          final book = gardenMainBookList[index];
          return GestureDetector(
            onTap: () {
              context.pushNamed('book-detail', extra: book.bookNo);
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
                  (book.bookImageUrl.isNotEmpty)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                              width: 44.r,
                              height: 44.r,
                              fit: BoxFit.fitWidth,
                              book.bookImageUrl),
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
                          book.bookTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          book.bookAuthor,
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
    final members = ref.watch(garden_feature.gardenMainMemberListProvider);
    final memberCount = members.length;

    if (memberCount == 0) {
      return const SizedBox.shrink();
    }

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
            child: AppAssets.profileFlower(members[0].userImage).image(),
          ),
          (memberCount >= 2)
              ? SizedBox(
                  width: 32.r * 2,
                  child: Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: AppAssets.profileFlower(members[1].userImage)
                        .image(),
                  ),
                )
              : Container(),
          (memberCount >= 3)
              ? SizedBox(
                  width: 100.w,
                  child: Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                    child: AppAssets.profileFlower(members[2].userImage)
                        .image(),
                  ),
                )
              : Container(),
          (memberCount == 4)
              ? SizedBox(
                  width: 140.w,
                  child: Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.amber),
                    child: AppAssets.profileFlower(members[3].userImage)
                        .image(),
                  ),
                )
              : Container(),
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
    final gardens = ref.watch(garden_feature.gardenListProvider);
    final gardenMain = ref.watch(garden_feature.gardenMainProvider);

    return SizedBox(
      height: 72.h,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: List.generate(
          gardens.length + 1,
          (index) {
            return (index != gardens.length)
                ? GestureDetector(
                    onTap: () {
                      garden_feature.updateMainGarden(
                          ref, gardens[index].gardenNo);
                      context.pop();
                      _scrollController.animateTo(
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
                                border: (gardens[index].gardenNo ==
                                        gardenMain.gardenNo)
                                    ? Border.all(
                                        width: 1.w, color: AppColors.black_59)
                                    : null,
                                shape: BoxShape.circle,
                                color: Colors.white),
                            child: AppAssets.iconBookmark.svg(
                              colorFilter: ColorFilter.mode(
                                Functions.gardenColor(
                                    gardens[index].gardenColor),
                                BlendMode.srcIn,
                              ),
                              width: 28.r,
                              height: 28.r,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 2.h),
                            height: 18.h,
                            child: Text(
                              gardens[index].gardenTitle,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: (gardens[index].gardenNo ==
                                          gardenMain.gardenNo)
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
                          child: AppAssets.iconAdd.svg(
                            colorFilter: const ColorFilter.mode(
                              AppColors.grey_8D,
                              BlendMode.srcIn,
                            ),
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
    final bookCount =
        ref.watch(garden_feature.gardenMainBookListProvider).length;

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
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: progress),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOut,
                      builder: (context, value, _) {
                        return Container(
                          margin: EdgeInsets.only(top: 6.h),
                          width: value * 272.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500.r),
                            color: Colors.black,
                          ),
                        );
                      },
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
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOut,
                      builder: (context, value, _) {
                        return Container(
                          margin: EdgeInsets.only(top: 6.h),
                          width: value * 272.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500.r),
                            color: Colors.black,
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ));
  }
}

class _FloatingBalloon extends StatefulWidget {
  const _FloatingBalloon();

  @override
  State<_FloatingBalloon> createState() => _FloatingBalloonState();
}

class _FloatingBalloonState extends State<_FloatingBalloon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _offset = Tween(begin: 0.0, end: -8.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offset,
      builder: (context, child) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Transform.translate(
              offset: Offset(7.w, _offset.value),
              child: child,
            ),
          ),
        );
      },
      child: SizedBox(
        width: 312.w,
        height: 52.h,
        child: Stack(
          children: [
            AppAssets.imageAdd.svg(),
            Positioned(
              left: 18.w,
              top: 0,
              bottom: 12.h,
              child: Center(
                child: Text(
                  '💡   + 버튼으로 새로운 책을 등록해보세요!',
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GardenMenuSheet extends StatefulWidget {
  const _GardenMenuSheet({
    required this.gardenMain,
    required this.gardenMainBookList,
    required this.gardenListWidget,
    required this.memberProfileWidget,
    required this.gardenProgressWidget,
    required this.bookListWidget,
    required this.onCapture,
    required this.scrollController,
  });

  final GardenMainEntity gardenMain;
  final List gardenMainBookList;
  final Widget gardenListWidget;
  final Widget memberProfileWidget;
  final Widget gardenProgressWidget;
  final Widget bookListWidget;
  final VoidCallback onCapture;
  final ScrollController scrollController;

  @override
  State<_GardenMenuSheet> createState() => _GardenMenuSheetState();
}

class _GardenMenuSheetState extends State<_GardenMenuSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _staggerItem(int index, Widget child) {
    final delay = (index * 0.12).clamp(0.0, 0.6);
    final end = (delay + 0.4).clamp(0.0, 1.0);
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(delay, end, curve: Curves.easeOut),
    );
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - animation.value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final gardenMain = widget.gardenMain;

    return SizedBox(
      height: 730.h,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(
              left: 24.w, right: 24.w, top: 38.h, bottom: 54.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _staggerItem(0, widget.gardenListWidget),
              _staggerItem(
                1,
                Container(
                  margin: EdgeInsets.only(top: 16.h, bottom: 8.h),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                            top: 56.h, left: 20.w, right: 20.w, bottom: 20.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              gardenMain.gardenInfo,
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            widget.gardenProgressWidget,
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
                            color:
                                Functions.gardenColor(gardenMain.gardenColor)),
                        child: Text(
                          gardenMain.gardenTitle,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _staggerItem(
                2,
                GestureDetector(
                  onTap: () {
                    context.pop();
                    context.pushNamed('garden-member',
                        extra: gardenMain.gardenNo);
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
                            widget.memberProfileWidget,
                            AppAssets.iconAngleRight.svg(
                              colorFilter: const ColorFilter.mode(
                                AppColors.grey_8D,
                                BlendMode.srcIn,
                              ),
                              width: 20.r,
                              height: 20.r,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              _staggerItem(
                3,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: widget.onCapture,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 64.r,
                            height: 64.r,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: AppAssets.iconPhoto.svg(
                              width: 28.r,
                              height: 28.r,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 8.h),
                            child: Text('사진찍기',
                                style: TextStyle(fontSize: 12.sp)),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pop();
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
                            child: AppAssets.iconEdit.svg(
                              width: 28.r,
                              height: 28.r,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 8.h),
                            child: Text('수정하기',
                                style: TextStyle(fontSize: 12.sp)),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                        Functions.shareBranchLink(
                            gardenMain.gardenTitle, gardenMain.gardenNo);
                      },
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 64.r,
                            height: 64.r,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: AppAssets.iconShare.svg(
                              width: 28.r,
                              height: 28.r,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 8.h),
                            child: Text('공유하기',
                                style: TextStyle(fontSize: 12.sp)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _staggerItem(
                4,
                GestureDetector(
                  onTap: () {
                    context.pushNamed('garden-book',
                        extra: gardenMain.gardenNo);
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
                        AppAssets.iconAngleRight.svg(
                          width: 20.r,
                          height: 20.r,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              _staggerItem(5, widget.bookListWidget),
            ],
          ),
        ),
      ),
    );
  }
}
