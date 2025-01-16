import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../core/api/AuthAPI.dart';
import '../core/api/GardenAPI.dart';
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Functions.dart';
import '../utils/Widgets.dart';

class GardenMemberPage extends ConsumerStatefulWidget {
  const GardenMemberPage({required this.garden_no});

  final int garden_no;

  _GardenMemberPageState createState() => _GardenMemberPageState();
}

class _GardenMemberPageState extends ConsumerState<GardenMemberPage> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    final gardenAPI = GardenAPI(ref);

    Future.microtask(() {
      gardenAPI.resetGardenMainMember();
      gardenAPI.getGardenDetail(widget.garden_no);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authAPI = AuthAPI(ref);
    final gardenAPI = GardenAPI(ref);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '멤버'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: gardenAPI.gardenMainMemberList().length > 1 &&
                  (gardenAPI.gardenMainMemberList()[0]['user_no'] ==
                      authAPI.user()['user_no']),
              child: GestureDetector(
                onTap: () {
                  context.pushNamed('garden-leader');
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10.h),
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24.w),
                        height: 46.h,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('대표 변경하기'),
                            SvgPicture.asset(
                              '${Constant.ASSETS_ICONS}icon_angle_right.svg',
                              color: AppColors.grey_8D,
                              width: 20.r,
                              height: 20.r,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        height: 1.h,
                        color: AppColors.grey_F2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20.h,
                left: 24.w,
                right: 24.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '멤버 ${gardenAPI.gardenMainMemberList().length}명',
                    style: const TextStyle(color: AppColors.grey_8D),
                  ),
                  ListView(
                    padding: EdgeInsets.only(top: 19.h),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                      gardenAPI.gardenMainMemberList().length,
                      (index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 24.h),
                          // height: 48.h,
                          child: Row(
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    width: 48.r,
                                    height: 48.r,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey),
                                  ),
                                  Visibility(
                                    visible:
                                        gardenAPI.gardenMainMemberList()[index]
                                            ['garden_leader'],
                                    child: SvgPicture.asset(
                                      '${Constant.ASSETS_ICONS}icon_leader.svg',
                                      width: 20.r,
                                      height: 20.r,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      gardenAPI.gardenMainMemberList()[index]
                                          ['user_nick'],
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    Text(
                                      (gardenAPI.gardenMainMemberList()[index]
                                              ['garden_leader'])
                                          ? '대표 가드너'
                                          : '가드너',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: AppColors.grey_8D),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Functions.shareBranchLink(
                          gardenAPI.gardenMain()['garden_title'],
                          gardenAPI.gardenMain()['garden_no']);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            '${Constant.ASSETS_ICONS}icon_add.svg',
                            color: AppColors.primaryColor,
                            width: 20.r,
                            height: 20.r,
                          ),
                          const Text(
                            '멤버 초대하기',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
