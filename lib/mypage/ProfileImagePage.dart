import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Widgets.dart';

//리스트 클릭 상태를 관리하는 프로바이더
final listClickProvider = StateProvider<int>((ref) => 0);

class ProfileImagePage extends ConsumerStatefulWidget {
  @override
  _ProfileImagePageState createState() => _ProfileImagePageState();
}

class _ProfileImagePageState extends ConsumerState<ProfileImagePage> {
  @override
  Widget build(BuildContext context) {
    final listIndex = ref.watch(listClickProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '대표 프로필 변경'),
      body: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 20.h),
                  child: CircleAvatar(
                    radius: 60.r,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    height: 26.h,
                    child: Text(
                      Constant.FLOWER_LIST[listIndex],
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    )),
                Text(
                  //TODO: - 설명 적용
                  '@데이지는 해가 뜨면 고개를 들고 해가 지면\n다시 고개를 내린다고 해서 태양의 눈이라고도 불려요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.black_4A,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40.h, bottom: 20.h),
                  height: 1.h,
                  color: AppColors.grey_F2,
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 24.w, right: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 22.h,
                    child: const Text(
                      '프로필 3/6',
                      style: TextStyle(color: AppColors.grey_8D),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24.h),
                    height: 242.h,
                    child: GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.8,
                          crossAxisCount: 3,
                          crossAxisSpacing: 28.w,
                          mainAxisSpacing: 24.h),
                      children: List.generate(
                        Constant.FLOWER_LIST.length,
                        (index) {
                          return (index <= 2)
                              ? GestureDetector(
                                  onTap: () {
                                    ref.read(listClickProvider.notifier).state =
                                        index;
                                  },
                                  child: SizedBox(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 80.r,
                                          height: 80.r,
                                          decoration: BoxDecoration(
                                              color: Colors.yellow,
                                              shape: BoxShape.circle,
                                              border: (listIndex == index)
                                                  ? Border.all(
                                                      color: AppColors
                                                          .primaryColor)
                                                  : null),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(top: 7.h),
                                            height: 22.h,
                                            child: Text(
                                                Constant.FLOWER_LIST[index]))
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 80.r,
                                        height: 80.r,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(top: 7.h),
                                          height: 22.h,
                                          child: Text(
                                            Constant.FLOWER_LIST[index],
                                            style: const TextStyle(
                                                color: AppColors.grey_8D),
                                          ))
                                    ],
                                  ),
                                );
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
