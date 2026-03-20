import 'package:book_flutter/core/ui/app_colors.dart';
import 'package:book_flutter/core/ui/app_widgets.dart';
import 'package:book_flutter/features/garden/presentation/providers/garden_provider.dart'
    as garden_feature;
import 'package:book_flutter/core/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

final gardenLeaderSelectIndexProvider = StateProvider<int>((ref) => 0);

class GardenLeaderPage extends ConsumerStatefulWidget {
  _GardenLeaderPageState createState() => _GardenLeaderPageState();
}

class _GardenLeaderPageState extends ConsumerState<GardenLeaderPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final members = ref.read(garden_feature.gardenMainMemberListProvider);
      ref.read(gardenLeaderSelectIndexProvider.notifier).state =
          members.isNotEmpty ? members[0]['user_no'] as int : 0;
    });
  }

  //가든 대표 변경 api
  void putGardenLeader() async {
    final gardenMain = ref.read(garden_feature.gardenMainProvider);
    final gardenNo = gardenMain.gardenNo;
    final userNo = ref.read(gardenLeaderSelectIndexProvider);

    final statusCode =
        await garden_feature.updateGardenLeader(ref, gardenNo, userNo);
    if (statusCode == 200) {
      context.pop();
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final members = ref.watch(garden_feature.gardenMainMemberListProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: Container(),
        centerTitle: true,
        title: Text(
          '대표 변경하기',
          style: TextStyle(fontSize: 16.sp),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              context.pop();
            },
            child: Container(
              alignment: Alignment.center,
              width: 60.r,
              height: 60.r,
              color: Colors.transparent,
              child: SvgPicture.asset(
                '${Constant.ASSETS_ICONS}icon_close.svg',
                width: 24.r,
                height: 24.r,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20.h, left: 24.w, right: 24.w),
          child: Column(
            children: [
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                  members.length,
                  (index) {
                    final member = members[index];
                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(gardenLeaderSelectIndexProvider.notifier)
                            .state = member['user_no'] as int;
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
                                    member['user_nick'],
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                              ],
                            ),
                            SvgPicture.asset(
                              (ref.watch(gardenLeaderSelectIndexProvider) ==
                                      member['user_no'])
                                  ? '${Constant.ASSETS_ICONS}icon_check_select.svg'
                                  : '${Constant.ASSETS_ICONS}icon_check_deselect.svg',
                              color:
                                  (ref.watch(gardenLeaderSelectIndexProvider) ==
                                          member['user_no'])
                                      ? null
                                      : AppColors.grey_CA,
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
