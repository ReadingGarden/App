import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../core/api/GardenAPI.dart';
import '../core/service/GardenService.dart';
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Functions.dart';
import '../utils/Widgets.dart';

final inviteGardenProvider = StateProvider<Map>((ref) => {});

class GardenInvitePage extends ConsumerStatefulWidget {
  GardenInvitePage({required this.garden_no});
  final int garden_no;

  _GardenInvitePageState createState() => _GardenInvitePageState();
}

class _GardenInvitePageState extends ConsumerState<GardenInvitePage> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

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
    final gardenAPI = GardenAPI(ref);
    final response = await gardenService.postGardenInvite(widget.garden_no);
    if (response?.statusCode == 201) {
      print('가든 초대 수락 완료');
      gardenAPI.putGardenMain(widget.garden_no);
      //TODO: - 가든 메인으로 가서 리스트 다시 불러와라
      context.pop();
      context.pop();
    } else if (response?.statusCode == 403) {
      fToast.showToast(child: Widgets.toast('멤버 정원이 꽉 차서 참여할 수 없어요'));
    } else if (response?.statusCode == 409) {
      fToast.showToast(child: Widgets.toast('이미 가입한 가든의 초대는 수락할 수 없어요'));
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
                    // height: 300.h,
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
                            '${Constant.ASSETS_ICONS}icon_bookmark.svg',
                            color: Functions.gardenColor(
                                inviteGarden['garden_color']),
                            width: 56.r,
                            height: 56.r,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16.h, bottom: 6.h),
                          child: Text(
                            inviteGarden['garden_title'],
                            style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black_59),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: SizedBox(
                            width: 232.w,
                            child: Text(
                              inviteGarden['garden_info'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: AppColors.black_59),
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
                        child: Widgets.button('초대 수락하기', true, () {
                          postGardenInvite();
                        }),
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
