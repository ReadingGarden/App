import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

//Switch 상태를 관리하는 ...
final switchProvider = StateProvider<bool>((ref) => false);

class AlertSettingPage extends ConsumerStatefulWidget {
  @override
  _AlertSettingPageState createState() => _AlertSettingPageState();
}

class _AlertSettingPageState extends ConsumerState<AlertSettingPage> {
  @override
  Widget build(BuildContext context) {
    // Switch 상태를 구독
    final switchState = ref.watch(switchProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '알림 설정'),
      body: Container(
        margin: EdgeInsets.only(top: 10.h),
        child: Column(
          children: [
            _titleSwitch('앱 알림', '새소식, 공지알림', switchState),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.h),
              height: 1.h,
              color: AppColors.grey_F2,
            ),
            _titleSwitch('독서 알림', '꾸준한 독서를 위해 알림을 설정해보세요', switchState),
            Widgets.titleList(
              '알림 시각',
              () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    builder: (context) {
                      return Container(
                        margin: EdgeInsets.only(
                          top: 30.h,
                          left: 24.w,
                          right: 24.w,
                        ),
                        height: 372.h,
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(bottom: 30.h),
                                width: 312.w,
                                height: 230.h,
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.time,
                                  onDateTimeChanged: (value) {},
                                )),
                            Widgets.button('확인', true, () {})
                          ],
                        ),
                      );
                    });
              },
              widget: Row(
                children: [
                  Text(
                    '@13:00',
                    style: const TextStyle(color: AppColors.grey_8D),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 8.w),
                    width: 20.r,
                    height: 20.r,
                    child: SvgPicture.asset(
                      'assets/images/angle-right-b.svg',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _titleSwitch(String title, String subTitle, bool value) {
    return Container(
      padding: EdgeInsets.only(left: 24.w, right: 24.w),
      height: 62.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
              ),
              Text(
                subTitle,
                style: TextStyle(fontSize: 12.sp, color: AppColors.grey_8D),
              ),
            ],
          ),
          FlutterSwitch(
            value: value,
            onToggle: (value) {
              // Switch 상태 업데이트
              ref.read(switchProvider.notifier).state = value;
            },
            width: 40.w,
            height: 20.h,
            toggleSize: 18.r,
            padding: 1.w,
            inactiveColor: AppColors.grey_CA,
            activeColor: AppColors.primaryColor,
          )
        ],
      ),
    );
  }
}
