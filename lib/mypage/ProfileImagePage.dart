import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../core/api/AuthAPI.dart';
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Widgets.dart';

//프로필 이미지 선택 인덱스 ...
final profileSelectIndexProvider = StateProvider<int>((ref) => 0);

class ProfileImagePage extends ConsumerStatefulWidget {
  @override
  _ProfileImagePageState createState() => _ProfileImagePageState();
}

class _ProfileImagePageState extends ConsumerState<ProfileImagePage> {
  @override
  void initState() {
    super.initState();

    // final authAPI = AuthAPI(ref);

    Future.microtask(() {
      ref.read(profileSelectIndexProvider.notifier).state =
          userProfileImageIndex();
    });
  }

  //유저 프로필 이미지 인덱스
  int userProfileImageIndex() {
    final authAPI = AuthAPI(ref);
    return Constant.FLOWER_LIST.indexOf(authAPI.user()['user_image']);
  }

  @override
  Widget build(BuildContext context) {
    final authAPI = AuthAPI(ref);
    final listIndex = ref.watch(profileSelectIndexProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '대표 프로필 변경', backFunction: () {
        final data = {
          "user_image":
              Constant.FLOWER_LIST[ref.watch(profileSelectIndexProvider)]
        };
        authAPI.putUser(context, data);
      }),
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
                  Constant.FLOWER_INFO_LIST[listIndex],
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
                  const Text(
                    '프로필 3/6',
                    style: TextStyle(color: AppColors.grey_8D),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24.h),
                    child: GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.8,
                          crossAxisCount: 3,
                          crossAxisSpacing: 28.w,
                          mainAxisSpacing: 24.h),
                      children: List.generate(
                        Constant.FLOWER_LIST.length,
                        (index) {
                          return (index <= 5)
                              ? GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(
                                            profileSelectIndexProvider.notifier)
                                        .state = index;
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
                                                      color: AppColors.black_4A)
                                                  : null),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(top: 7.h),
                                            child: Text(
                                                Constant.FLOWER_LIST[index],
                                                style: TextStyle(
                                                    color: (listIndex == index)
                                                        ? Colors.black
                                                        : AppColors.grey_8D)))
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
