import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/api/GardenAPI.dart';
import '../core/service/GardenService.dart';
import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

final inviteGardenProvider = StateProvider<Map>((ref) => {});

class GardenInvitePage extends ConsumerStatefulWidget {
  GardenInvitePage({required this.garden_no});
  final int garden_no;

  _GardenInvitePageState createState() => _GardenInvitePageState();
}

class _GardenInvitePageState extends ConsumerState<GardenInvitePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(inviteGardenProvider.notifier).state = {};
    });
    getInviteGarden();
  }

  //초대 가든 조회 api
  void getInviteGarden() async {
    final response = await gardenService.getGardenDetail(widget.garden_no);
    if (response?.statusCode == 200) {
      print('초대 가든 조회 성공');
      ref.read(inviteGardenProvider.notifier).state = response?.data['data'];
    }
  }

  //가든 초대 수락 api
  void postGardenInvite() async {
    final response = await gardenService.postGardenInvite(widget.garden_no);
    if (response?.statusCode == 201) {
      print('가든 초대 수락 완료');
    } else if (response?.statusCode == 403) {
      print('멤버 초과 토스트 띄우렴');
    }
  }

  @override
  Widget build(BuildContext context) {
    final inviteGarden = ref.watch(inviteGardenProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: Container(),
      ),
      body: (inviteGarden.isNotEmpty)
          ? Container(
              margin: EdgeInsets.only(left: 24.w, right: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.w600),
                      children: const [
                        TextSpan(
                            text: '공유가든',
                            style: TextStyle(color: AppColors.primaryColor)),
                        TextSpan(text: '에 초대받았어요')
                      ])),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: const Text(
                      '초대 수락하기 버튼을 눌러 다른 가드너와 함께\n책을 기록하고 공유해보세요!',
                      style: TextStyle(color: AppColors.grey_8D),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40.h, bottom: 65.h),
                    padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
                    width: 312.w,
                    height: 300.h,
                    decoration: BoxDecoration(
                        color: AppColors.grey_FA,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 104.r,
                          height: 104.r,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: SvgPicture.asset(
                            'assets/images/garden-color.svg',
                            // color: Functions.gardenColor(gardenAPI
                            //     .gardenList()[index]['garden_color']),
                            width: 40.w,
                            height: 60.h,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16.h, bottom: 6.h),
                          child: Text(
                            inviteGarden['garden_title'],
                            style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black_4A),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: SizedBox(
                            width: 232.w,
                            child: Text(
                              inviteGarden['garden_info'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: AppColors.black_4A),
                            ),
                          ),
                        ),
                        Text(
                          '멤버 ${inviteGarden['garden_members'].length}/10',
                          style: const TextStyle(color: AppColors.grey_8D),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Widgets.button('초대 수락하기', true, () {}),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Container(
                          height: 60.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: AppColors.grey_CA),
                          child: Center(
                              child: Text(
                            '거절하기',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
