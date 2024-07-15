import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../garden/GardenPage.dart';
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Widgets.dart';

class BookRegisterPage extends ConsumerStatefulWidget {
  const BookRegisterPage({required this.book});

  final Map book;

  _BookRegisterPageState createState() => _BookRegisterPageState();
}

class _BookRegisterPageState extends ConsumerState<BookRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Widgets.appBar(context, title: '책 등록하기'),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.only(bottom: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 88.h,
                  margin: EdgeInsets.only(left: 24.w, right: 24.w),
                  child: Row(children: [
                    (widget.book['cover'] != null && widget.book['cover'] != '')
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              width: 48.w,
                              height: 64.h,
                              fit: BoxFit.cover,
                              widget.book['cover'],
                            ),
                          )
                        : Container(
                            width: 48.w,
                            height: 64.h,
                            decoration: BoxDecoration(
                                color: AppColors.grey_F2,
                                borderRadius: BorderRadius.circular(8.r)),
                          ),
                    Container(
                      margin: EdgeInsets.only(left: 12.w),
                      width: 252.w,
                      // height: 48.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            widget.book['title'],
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            widget.book['author'],
                            style: TextStyle(
                                fontSize: 12.sp, color: AppColors.grey_8D),
                          ),
                        ],
                      ),
                    ),
                  ])),
              Container(
                height: 1.h,
                color: AppColors.grey_F2,
              ),
              Container(
                  margin: EdgeInsets.only(top: 30.h, left: 24.w, right: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '어느 가든에 심을까요?',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      _gardenList()
                    ],
                  )),
              Container(
                  margin: EdgeInsets.only(top: 43.h, left: 24.w),
                  child: Text(
                    '어떤 꽃으로 자랄까요?',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  )),
              _flowerList(),
              Container(
                  margin: EdgeInsets.only(top: 40.h, left: 24.w, right: 24.w),
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 16.h),
                          child: Text(
                            '언제 읽기 시작했나요?',
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              hintText: '2024/03/01',
                              hintStyle: TextStyle(
                                  fontSize: 16.sp, color: AppColors.grey_8D),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide:
                                    const BorderSide(color: AppColors.grey_F2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide:
                                    const BorderSide(color: AppColors.grey_F2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide:
                                    const BorderSide(color: AppColors.grey_F2),
                              )),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        )),
        bottomNavigationBar: Container(
            margin: EdgeInsets.only(
                left: 24.w, right: 24.w, bottom: 30.h, top: 10.h),
            child: Widgets.button(
                '등록하기', true, () => context.pushNamed('book-register-done'))));
  }

  Widget _gardenList() {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      height: (68.h + 10.h) * ref.watch(gardenListProvider).length,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          ref.watch(gardenListProvider).length,
          (index) {
            return Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  height: 68.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.black_4A),
                      color: AppColors.grey_FA),
                  child: SizedBox(
                    height: 44.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ref.watch(gardenListProvider)[index]['garden_title'],
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        //TODO: - 심은 꽃
                        Text(
                          '@심은 꽃 23/30',
                          style: TextStyle(
                              fontSize: 12.sp, color: AppColors.grey_8D),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.w),
                  child: SvgPicture.asset(
                    'assets/images/garden-color_icon.svg',
                    width: 20.w,
                    // color: ref.watch(gardenListProvider)[index]['garden_color'],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _flowerList() {
    return Container(
      margin: EdgeInsets.only(top: 13.h),
      height: 148.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          Constant.FLOWER_LIST.length,
          (index) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      right: 8.w, left: (index == 0) ? 24.w : 0, bottom: 8.h),
                  width: 120.r,
                  height: 120.r,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.black),
                      color: Colors.amber),
                ),
                SizedBox(
                  height: 20.h,
                  child: Text(
                    Constant.FLOWER_LIST[index],
                    style: TextStyle(fontSize: 14.sp, color: AppColors.grey_8D),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class BookRegisterDonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 142.h),
          child: Center(
            child: Column(
              children: [
                Text.rich(
                    style:
                        TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
                    TextSpan(children: [
                      TextSpan(
                          text: '@행복한 쿼카의 가든',
                          style: TextStyle(color: AppColors.primaryColor)),
                      TextSpan(text: '에')
                    ])),
                Text(
                  '새로운 책을 심었어요',
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40.h),
                  width: 312.r,
                  height: 312.r,
                  color: Colors.amber,
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
          child: Widgets.button('가든으로 가기', true, () {}),
        ));
  }
}
