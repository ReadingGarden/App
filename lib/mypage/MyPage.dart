import 'package:book_flutter/core/provider/ResponseProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/provider/AuthServiceProvider.dart';
import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

class MyPage extends ConsumerStatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  //프로필 조회 api
  void getProfile() async {
    final response =
        await ref.read(AuthServiceProvider.getProfileProvider.future);
    if (response?.statusCode == 200) {
      ref.read(userResponseProvider.notifier).state = response?.data['data'];

      print('성공');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userResponse = ref.watch(userResponseProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30.h,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.only(bottom: 24.h),
        child: Container(
          margin: EdgeInsets.only(bottom: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 14.w),
                          child: CircleAvatar(
                            radius: 30.r,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 2.h),
                              height: 24.h,
                              child: Text(
                                userResponse['user_nick'] ?? '',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                                height: 20.h,
                                child: Text(userResponse['user_email'] ?? '',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.textLightGreyColor))),
                          ],
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20.h, bottom: 40.h),
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      width: 312.w,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.borderGreyColor.withOpacity(0.95),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    AppColors.shadowGreyColor.withOpacity(0.05),
                                offset: const Offset(4, 4),
                                blurRadius: 8.r)
                          ],
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.white),
                      child: SizedBox(
                        width: 240.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                  child: Text(
                                    '가든 수',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.textLightGreyColor),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 1.h),
                                  height: 24.h,
                                  child: Text(
                                    userResponse['garden_count'].toString(),
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                  child: Text(
                                    '읽은 책',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.textLightGreyColor),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 1.h),
                                  height: 24.h,
                                  child: Text(
                                    userResponse['read_book_count'].toString(),
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                  child: Text(
                                    '찜한 책',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.textLightGreyColor),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 1.h),
                                  height: 24.h,
                                  child: Text(
                                    userResponse['like_book_count'].toString(),
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 8.h,
                margin: EdgeInsets.only(bottom: 24.h),
                color: AppColors.thickDividerGreyColor,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _subTitleList('설정'),
                  _titleList('프로필', () {
                    context.goNamed('profile');
                  }),
                  _titleList('계정 관리', () {}),
                  _titleList('알림 설정', () {}),
                  Container(
                    margin: EdgeInsets.only(top: 20.h, bottom: 24.h),
                    height: 1.h,
                    color: AppColors.lightDividerGreyColor.withOpacity(0.9),
                  ),
                  _subTitleList('지원'),
                  _titleList('이용 가이드', () {
                    ref.read(userResponseProvider.notifier).state['user_nick'] =
                        '변경';

                    print('이용가이드 페이지로');
                  }),
                  _titleList('1:1 문의하기', () {
                    print('1:1 문의하기 페이지로');
                  }),
                  _titleList('의견 보내기', () {
                    print('의견보내기 페이지로');
                  }),
                  _titleList('리뷰 작성하기', () {
                    print('리뷰작성하기 페이지로');
                  }),
                  Container(
                    margin: EdgeInsets.only(top: 20.h, bottom: 24.h),
                    height: 1.h,
                    color: AppColors.lightDividerGreyColor.withOpacity(0.9),
                  ),
                  _subTitleList('기타'),
                  _titleList('이용 약관', () {
                    print('이용 약관 페이지로');
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleList(String title, Function function) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        padding: EdgeInsets.only(left: 24.w),
        alignment: Alignment.centerLeft,
        color: Colors.transparent,
        width: 360.w,
        height: 46.h,
        child: Text(
          title,
          style: TextStyle(fontSize: 14.sp),
        ),
      ),
    );
  }

  Widget _subTitleList(String subTitle) {
    return Container(
      padding: EdgeInsets.only(left: 24.w),
      margin: EdgeInsets.only(bottom: 10.h),
      width: 312.w,
      height: 20.h,
      child: Text(
        subTitle,
        style: TextStyle(fontSize: 12.sp, color: AppColors.textLightGreyColor),
      ),
    );
  }
}
