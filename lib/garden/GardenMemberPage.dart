import 'package:book_flutter/X/model/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/provider/ResponseProvider.dart';
import '../core/service/GardenService.dart';
import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

final gardenMemberListProvider = StateProvider<List>((ref) => []);

class GardenMemberPage extends ConsumerStatefulWidget {
  const GardenMemberPage({required this.garden_no});

  final int garden_no;

  _GardenMemberPageState createState() => _GardenMemberPageState();
}

class _GardenMemberPageState extends ConsumerState<GardenMemberPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(gardenMemberListProvider.notifier).state = [];
    });
    getGardenDetail(widget.garden_no);
  }

  //가든 상세 조회 api
  void getGardenDetail(int garden_no) async {
    final response = await gardenService.getGardenDetail(garden_no);
    if (response?.statusCode == 200) {
      ref.read(gardenMemberListProvider.notifier).state =
          response?.data['data']['garden_members'];
    } else if (response?.statusCode == 401) {
      print('토큰에러');
    }
  }

  @override
  Widget build(BuildContext context) {
    final gardenMemberList = ref.watch(gardenMemberListProvider);
    final user = ref.watch(responseProvider.userMapProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '멤버'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: gardenMemberList.length > 1 &&
                  (gardenMemberList[0]['user_no'] == user?['user_no']),
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
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/users-alt.svg',
                                  width: 18.r,
                                  height: 18.r,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 9.w),
                                  child: Text('대표 변경하기'),
                                ),
                              ],
                            ),
                            SvgPicture.asset(
                              'assets/images/member-angle-right-b.svg',
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
                    '멤버 ${gardenMemberList.length}명',
                    style: const TextStyle(color: AppColors.grey_8D),
                  ),
                  ListView(
                    padding: EdgeInsets.only(top: 19.h),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                      gardenMemberList.length,
                      (index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 24.h),
                          height: 48.h,
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
                                    visible: gardenMemberList[index]
                                        ['garden_leader'],
                                    child: Container(
                                      width: 18.r,
                                      height: 18.r,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black),
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
                                      gardenMemberList[index]['user_nick'],
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    Text(
                                      (gardenMemberList[index]['garden_leader'])
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
                      _memberBottomSheet();
                    },
                    child: Container(
                      height: 22.h,
                      color: Colors.transparent,
                      child: const Text(
                        '+ 멤버 초대하기',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold),
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

  Future _memberBottomSheet() {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 30.h, left: 24.w, right: 24.w),
          height: 206.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Text(
                  '멤버 초대하기',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 64.r,
                        height: 64.r,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.grey_F2),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 8.h),
                        height: 20.h,
                        child: Text(
                          '카카오톡',
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 64.r,
                        height: 64.r,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.grey_F2),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 8.h),
                        height: 20.h,
                        child: Text(
                          '문자',
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 64.r,
                        height: 64.r,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.grey_F2),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 8.h),
                        height: 20.h,
                        child: Text(
                          '링크복사',
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 64.r,
                        height: 64.r,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.grey_F2),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 8.h),
                        height: 20.h,
                        child: Text(
                          '더보기',
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
