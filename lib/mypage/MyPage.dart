import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/provider/ResponseProvider.dart';
import '../core/service/AuthService.dart';
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
    final response = await authService.getProfile();
    if (response?.statusCode == 200) {
      ref.read(responseProvider.userMapProvider.notifier).state =
          response?.data['data'];
    } else if (response?.statusCode == 401) {
      context.pushNamed('start');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(responseProvider.userMapProvider);

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
                                user?['user_nick'] ?? '',
                                // user?.user_nick ?? '',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                                height: 20.h,
                                child: Text(user?['user_email'] ?? '',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.grey_8D))),
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
                            color: AppColors.grey_FA,
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
                                        color: AppColors.grey_8D),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 1.h),
                                  height: 24.h,
                                  child: Text(
                                    user?['garden_count'].toString() ?? '0',
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
                                        color: AppColors.grey_8D),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 1.h),
                                  height: 24.h,
                                  child: Text(
                                    user?['read_book_count'].toString() ?? '0',
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
                                        color: AppColors.grey_8D),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 1.h),
                                  height: 24.h,
                                  child: Text(
                                    user?['like_book_count'].toString() ?? '0',
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
                color: AppColors.grey_FA,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _subTitleList('설정'),
                  Widgets.titleList('프로필', () => context.pushNamed('profile')),
                  Widgets.titleList(
                      '계정 관리', () => context.pushNamed('auth-manage')),
                  Widgets.titleList('알림 설정', () => context.pushNamed('alert')),
                  Container(
                    margin: EdgeInsets.only(top: 20.h, bottom: 24.h),
                    height: 1.h,
                    color: AppColors.grey_F2,
                  ),
                  _subTitleList('지원'),
                  Widgets.titleList('이용 가이드', () {
                    print('이용가이드 페이지로');
                  }),
                  Widgets.titleList('1:1 문의하기', () {
                    print('1:1 문의하기 페이지로');
                  }),
                  Widgets.titleList('의견 보내기', () {
                    print('의견보내기 페이지로');
                  }),
                  Widgets.titleList('리뷰 작성하기', () {
                    print('리뷰작성하기 페이지로');
                  }),
                  Container(
                    margin: EdgeInsets.only(top: 20.h, bottom: 24.h),
                    height: 1.h,
                    color: AppColors.grey_F2,
                  ),
                  _subTitleList('기타'),
                  Widgets.titleList('이용 약관', () {
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

  Widget _subTitleList(String subTitle) {
    return Container(
      padding: EdgeInsets.only(left: 24.w),
      margin: EdgeInsets.only(bottom: 10.h),
      width: 312.w,
      height: 20.h,
      child: Text(
        subTitle,
        style: TextStyle(fontSize: 12.sp, color: AppColors.grey_8D),
      ),
    );
  }
}
