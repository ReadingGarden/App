import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/api/GardenAPI.dart';
import '../utils/AppColors.dart';
import '../utils/Functions.dart';
import '../utils/Widgets.dart';

class GardenPage extends ConsumerStatefulWidget {
  @override
  _GardenPageState createState() => _GardenPageState();
}

class _GardenPageState extends ConsumerState<GardenPage> {
  @override
  void initState() {
    super.initState();

    final gardenAPI = GardenAPI(ref);

    Future.microtask(() {
      gardenAPI.resetGardenMain();
      gardenAPI.getGardenLsit();
    });
  }

  @override
  Widget build(BuildContext context) {
    final gardenAPI = GardenAPI(ref);

    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              _gardenMenuBottomSheet();
            },
            child: (gardenAPI.gardenMain().isNotEmpty)
                ? Container(
                    margin: EdgeInsets.only(top: 80.h, left: 24.w, right: 24.w),
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
                              borderRadius: BorderRadius.circular(20.r)),
                          child: SizedBox(
                            height: 48.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      gardenAPI.gardenMain()['garden_title'],
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
                            Container(
                                margin: EdgeInsets.only(top: 12.h),
                                width: 272.w,
                                // height: 34.h,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('가든을 다 채웠어요!'),
                                        Text(
                                          '${gardenAPI.gardenMainBookList().length}/30',
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 6.h),
                                      height: 8.h,
                                      color: Colors.black,
                                    )
                                  ],
                                ))
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
                            color: AppColors.primaryColor),
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
}
