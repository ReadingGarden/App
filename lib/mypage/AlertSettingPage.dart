import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:go_router/go_router.dart';

import '../core/service/PushService.dart';
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Functions.dart';
import '../utils/Widgets.dart';

//App Switch 상태를 관리하는 ...
final appSwitchProvider = StateProvider<bool>((ref) => false);

//Book Switch 상태를 관리하는 ...
final bookSwitchProvider = StateProvider<bool>((ref) => false);

//선택된 시간을 관리하는 ...
final timeProvider = StateProvider<DateTime>((ref) => DateTime.now());

class AlertSettingPage extends ConsumerStatefulWidget {
  @override
  _AlertSettingPageState createState() => _AlertSettingPageState();
}

class _AlertSettingPageState extends ConsumerState<AlertSettingPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(appSwitchProvider.notifier).state = false;
      ref.read(bookSwitchProvider.notifier).state = false;
      ref.read(timeProvider.notifier).state = DateTime.now();
    });
    getPush();
  }

  //푸시 알림 조회 api
  void getPush() async {
    final response = await pushService.getPush();
    if (response?.statusCode == 200) {
      ref.read(appSwitchProvider.notifier).state =
          response?.data['data']['push_app_ok'];

      ref.read(bookSwitchProvider.notifier).state =
          response?.data['data']['push_book_ok'];

      ref.read(timeProvider.notifier).state =
          DateTime.parse(response?.data['data']['push_time']);
    }
  }

  //푸시 알림 수정 api
  void putPush(Map data) async {
    final response = await pushService.putPush(data);
    if (response?.statusCode == 200) {
      print(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appSwitchState = ref.watch(appSwitchProvider);
    final bookSwitchState = ref.watch(bookSwitchProvider);
    // 선택된 시간을 구독
    final selectedTime = ref.watch(timeProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '알림 설정'),
      body: Container(
        margin: EdgeInsets.only(top: 10.h),
        child: Column(
          children: [
            _titleSwitch('앱 알림', '새소식, 공지알림', appSwitchState),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.h),
              height: 1.h,
              color: AppColors.grey_F2,
            ),
            _titleSwitch('독서 알림', '꾸준한 독서를 위해 알림을 설정해보세요', bookSwitchState),
            Widgets.titleList(
              '알림 시각',
              () {
                if (ref.watch(bookSwitchProvider)) {
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
                                    initialDateTime: selectedTime,
                                    onDateTimeChanged: (newTime) {
                                      //선택된 시간 상태 업데이트
                                      ref.read(timeProvider.notifier).state =
                                          newTime;
                                    },
                                  )),
                              Widgets.button('확인', true, () {
                                final data = {
                                  "push_time":
                                      ref.watch(timeProvider).toString()
                                };
                                putPush(data);
                                context.pop();
                              })
                            ],
                          ),
                        );
                      });
                }
              },
              widget: Row(
                children: [
                  Text(
                    Functions.formatTime(selectedTime).toString(),
                    style: const TextStyle(color: AppColors.grey_8D),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8.w),
                    child: SvgPicture.asset(
                      '${Constant.ASSETS_ICONS}icon_angle_right.svg',
                      color: AppColors.grey_8D,
                      width: 20.r,
                      height: 20.r,
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
              if (title == '앱 알림') {
                // Switch 상태 업데이트
                ref.read(appSwitchProvider.notifier).state = value;

                final data = {"push_app_ok": value};
                putPush(data);
              } else {
                // Switch 상태 업데이트
                ref.read(bookSwitchProvider.notifier).state = value;

                final data = {"push_book_ok": value};
                putPush(data);
              }
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
