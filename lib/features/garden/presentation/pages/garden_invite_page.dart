import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'package:book_flutter/core/common/functions.dart';
import 'package:book_flutter/core/ui/app_assets.dart';
import 'package:book_flutter/core/ui/app_colors.dart';
import 'package:book_flutter/core/ui/app_widgets.dart';
import 'package:book_flutter/features/garden/domain/entities/garden_main_entity.dart';
import 'package:book_flutter/features/garden/presentation/providers/garden_provider.dart'
    as garden_feature;

class GardenInvitePage extends ConsumerStatefulWidget {
  const GardenInvitePage({super.key, required this.gardenNo});
  final int gardenNo;

  @override
  ConsumerState<GardenInvitePage> createState() => _GardenInvitePageState();
}

class _GardenInvitePageState extends ConsumerState<GardenInvitePage> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    Future.microtask(() {
      ref.read(garden_feature.inviteGardenProvider.notifier).state =
          GardenMainEntity.empty;
    });
    getInviteGarden();
  }

  //초대 가든 조회 api
  void getInviteGarden() async {
    await garden_feature.fetchInviteGarden(ref, widget.gardenNo);
  }

  //가든 초대 수락 api
  void postGardenInvite() async {
    final statusCode =
        await garden_feature.acceptGardenInvite(ref, widget.gardenNo);
    if (statusCode == 201) {
      if (!mounted) {
        return;
      }
      context.pop();
      context.pop();
    } else if (statusCode == 403) {
      fToast.showToast(child: Widgets.toast('멤버 정원이 꽉 차서 참여할 수 없어요'));
    } else if (statusCode == 409) {
      fToast.showToast(child: Widgets.toast('이미 가입한 가든의 초대는 수락할 수 없어요'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final inviteGarden = ref.watch(garden_feature.inviteGardenProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: Container(),
      ),
      body: (!inviteGarden.isEmpty)
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
                          child: AppAssets.iconBookmark.svg(
                            colorFilter: ColorFilter.mode(
                              Functions.gardenColor(inviteGarden.gardenColor),
                              BlendMode.srcIn,
                            ),
                            width: 56.r,
                            height: 56.r,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16.h, bottom: 6.h),
                          child: Text(
                            inviteGarden.gardenTitle,
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
                              inviteGarden.gardenInfo,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: AppColors.black_59),
                            ),
                          ),
                        ),
                        Text(
                          '멤버 ${inviteGarden.gardenMembers.length}/10',
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
