import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final PageController _pageController = PageController();
  final List titleList = [
    '내가 읽고 있는 책,\n독서가든에서 키워볼까?',
    '친구와 함께 키워나가는\n우리의 공유 가든',
    '내가 읽는 책이 모여서\n꽃을 피워낼때까지'
  ];
  final List contentList = [
    '하루하루 꾸준히 책을 보다보면\n내가 읽은 책이 꽃이 되어 가든을 가득 채울거에요',
    '함께 공유 가든에 나무를 심으면 더 풍성해져요. \n그리고 어쩌면 친구의 책을 따라 읽게 될지도?',
    '독서는 꾸준함이 생명이죠.\n까먹지 않도록 원하는 때에 알림을 보내드릴게요!'
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: 3,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return startContainer(index);
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 30.h),
              child: SizedBox(
                  width: 34.w,
                  height: 6.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: List.generate(3, (int index) {
                      return Container(
                        padding: EdgeInsets.only(right: 8.w),
                        child: CircleAvatar(
                          radius: 3.r,
                          backgroundColor: (index == _currentIndex)
                              ? AppColors.primaryColor
                              : AppColors.grey_CA,
                        ),
                      );
                    }),
                  )),
            )
          ],
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 32.h, left: 24.w, right: 24.w),
          child: Widgets.button('시작하기', true, () => context.goNamed('login')),
        ));
  }

  Widget startContainer(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 360.w,
              height: 400.h,
              child: Image.asset(
                'assets/images/start_${index + 1}.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 30.h, left: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Text(
                        titleList[index],
                        style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.33.h),
                      ),
                    ),
                    Text(
                      contentList[index],
                      style:
                          TextStyle(fontSize: 14.sp, color: AppColors.grey_8D),
                    ),
                  ],
                )),
          ],
        ),
      ],
    );
  }
}
