import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/service/GardenService.dart';
import '../utils/AppColors.dart';
import '../utils/Widgets.dart';
import 'GardenMemberPage.dart';
import 'GardenPage.dart';

final gardenLeaderSelectIndexProvider = StateProvider<int>(
    (ref) => ref.watch(gardenMemberListProvider)[0]['user_no']);

class GardenLeaderPage extends ConsumerStatefulWidget {
  _GardenLeaderPageState createState() => _GardenLeaderPageState();
}

class _GardenLeaderPageState extends ConsumerState<GardenLeaderPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(gardenLeaderSelectIndexProvider.notifier).state =
          ref.watch(gardenMemberListProvider)[0]['user_no'];
    });
  }

  //가든 대표 변경 api
  void putGardenLeader() async {
    final garden_no = ref.watch(gardenMainProvider)['garden_no'];
    final user_no = ref.watch(gardenLeaderSelectIndexProvider);

    final response = await gardenService.putGardenLeader(garden_no, user_no);
    if (response?.statusCode == 200) {
      context.pop();
      context.pop();
    } else if (response?.statusCode == 401) {}
  }

  @override
  Widget build(BuildContext context) {
    final gardenMemberList = ref.watch(gardenMemberListProvider);

    return Scaffold(
      appBar: Widgets.appBar(context),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20.h, left: 24.w, right: 24.w),
          child: Column(
            children: [
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                  gardenMemberList.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(gardenLeaderSelectIndexProvider.notifier)
                            .state = gardenMemberList[index]['user_no'];
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 24.h),
                        height: 48.h,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 48.r,
                                  height: 48.r,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 12.w),
                                  child: Text(
                                    gardenMemberList[index]['user_nick'],
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                              ],
                            ),
                            SvgPicture.asset(
                              (ref.watch(gardenLeaderSelectIndexProvider) ==
                                      gardenMemberList[index]['user_no'])
                                  ? 'assets/images/garden-check-circle.svg'
                                  : 'assets/images/garden-check-circle-dis.svg',
                              width: 24.r,
                              height: 24.r,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 30.h, left: 24.w, right: 24.w),
          child: Widgets.button('저장하기', true, () => putGardenLeader())),
    );
  }
}
