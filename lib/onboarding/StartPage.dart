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
    '함께 심고, 함께 키우는\n우리들의 공유가든',
    '책 읽는 시간 잊지 않도록\n꼭 챙겨드릴게요'
  ];
  final List contentList = [
    '하루하루 꾸준히 책을 보다보면\n내가 읽은 책이 꽃이 되어 가든을 가득 채울거에요',
    '친구들과 하나의 가든에서 꽃을 키워보세요.\n서로의 꽃이 자라는 걸 보며 독서 열정도 쑥쑥 자랄 거예요.',
    '끝까지 완독하려면 매일 꾸준히 읽는 게 중요해요.\n읽은 페이지만큼 물을 주며 꽃이 피어나게 도와주세요!'
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
