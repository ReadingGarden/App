import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/api/AuthAPI.dart';
import '../utils/AppColors.dart';
import '../utils/Functions.dart';
import '../utils/Widgets.dart';

class MyPage extends ConsumerStatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  @override
  void initState() {
    super.initState();

    final authAPI = AuthAPI(ref);

    Future.microtask(() {
      authAPI.getUser(context);
    });
  }

  //메일 보내기
  Future<void> sendEmail() async {
    final Email email = Email(
      body: "",
      subject: "ㅇㅇ",
      recipients: ["dokseogardenapp@gmail.com"],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('이메일이 성공적으로 전송되었습니다.')));
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('이메일 전송 중 오류가 발생했습니다: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authAPI = AuthAPI(ref);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30.h,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leadingWidth: 0,
        leading: Container(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                              // height: 24.h,
                              child: Text(
                                authAPI.user()['user_nick'] ?? '',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                                // height: 20.h,
                                child: Text(authAPI.user()['user_email'] ?? '',
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
                                  // height: 24.h,
                                  child: Text(
                                    authAPI.user()['garden_count'].toString(),
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
                                  // height: 24.h,
                                  child: Text(
                                    authAPI
                                        .user()['read_book_count']
                                        .toString(),
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
                                  // height: 24.h,
                                  child: Text(
                                    authAPI
                                        .user()['like_book_count']
                                        .toString(),
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
                    Functions.launchURL(
                        "https://www.notion.so/dokseogarden/1082d8001a9280f58ea8ea9916edbfea?v=b441041520b3422691c9f0d9cb091474&pvs=4");
                  }),
                  Widgets.titleList('1:1 문의하기', () {
                    print('1:1 문의하기 페이지로');
                  }),
                  Widgets.titleList('의견 보내기', () {
                    sendEmail();
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
                  Widgets.titleList('이용 약관', () => context.pushNamed('tos')),
                  Widgets.titleList('개발자 홈페이지 바로가기', () {
                    Functions.launchURL(
                        "https://dokseogarden.notion.site/74d8c0678a4e49e6ab2e2152cfae24c7");
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
