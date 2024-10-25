import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/AppColors.dart';
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
              () {},
              widget: Container(
                alignment: Alignment.center,
                width: 20.r,
                height: 20.r,
                child: SvgPicture.asset(
                  'assets/images/angle-right-b.svg',
                ),
              ),
            ),
            Widgets.titleList(
              '개인정보처리방침',
              () {},
              widget: Container(
                alignment: Alignment.center,
                width: 20.r,
                height: 20.r,
                child: SvgPicture.asset(
                  'assets/images/angle-right-b.svg',
                ),
              ),
            ),
            Widgets.titleList(
              '개인정보 수집·이용 동의서',
              () {},
              widget: Container(
                alignment: Alignment.center,
                width: 20.r,
                height: 20.r,
                child: SvgPicture.asset(
                  'assets/images/angle-right-b.svg',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
