import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Functions.dart';
import '../utils/Widgets.dart';

class TosPage extends ConsumerStatefulWidget {
  @override
  _TosPageState createState() => _TosPageState();
}

class _TosPageState extends ConsumerState<TosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context, title: '이용 약관'),
      body: Container(
        margin: EdgeInsets.only(top: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widgets.titleList(
              '서비스 이용약관',
              () {
                Functions.launchURL(
                    "https://www.notion.so/dokseogarden/825ddd95b1084d689c4275ae665510b5?pvs=4");
              },
              widget: SvgPicture.asset(
                '${Constant.ASSETS_ICONS}icon_angle_right.svg',
                color: AppColors.grey_8D,
                width: 20.r,
                height: 20.r,
              ),
            ),
            Widgets.titleList(
              '개인정보처리방침',
              () {
                Functions.launchURL(
                    "https://www.notion.so/dokseogarden/dac7d2c7f8b241d8944a5ff957fab3ab?pvs=4");
              },
              widget: SvgPicture.asset(
                '${Constant.ASSETS_ICONS}icon_angle_right.svg',
                color: AppColors.grey_8D,
                width: 20.r,
                height: 20.r,
              ),
            ),
            Widgets.titleList(
              '개인정보 수집·이용 동의서',
              () {
                Functions.launchURL(
                    "https://www.notion.so/dokseogarden/1182d8001a928098bb71c78cc5523cd4?pvs=4");
              },
              widget: SvgPicture.asset(
                '${Constant.ASSETS_ICONS}icon_angle_right.svg',
                color: AppColors.grey_8D,
                width: 20.r,
                height: 20.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
