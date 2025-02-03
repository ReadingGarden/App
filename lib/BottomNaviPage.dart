import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'book/BookshelfPage.dart';
import 'core/api/GardenAPI.dart';
import 'garden/GardenPage.dart';
import 'memo/MemoPage.dart';
import 'mypage/MyPage.dart';
import 'utils/AppColors.dart';
import 'utils/Constant.dart';

//현재 선택된 인덱스를 관리하는 ...
final currentIndexProvider = StateProvider<int>((ref) => 0);

class BottomNaviPage extends ConsumerWidget {
  const BottomNaviPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gardenAPI = GardenAPI(ref);

    //현재 선택된 인덱스를 watch
    final currentIndex = ref.watch(currentIndexProvider);

    return Scaffold(
      backgroundColor: (ref.read(currentIndexProvider.notifier).state == 0)
          ? const Color(0xff92AC7D)
          : Colors.white,
      body: IndexedStack(
        index: currentIndex,
        children: [GardenPage(), BookShelfPage(), MemoPage(), MyPage()],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTabSelected: (index) {
          //선택된 인덱스를 업데이트
          ref.read(currentIndexProvider.notifier).state = index;
          if (ref.read(currentIndexProvider.notifier).state == 0) {
            //가든 페이지 리프레시
            gardenAPI.getGardenLsit();
          }
        },
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  CustomBottomNavigationBar(
      {required this.currentIndex, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      height: 70.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTabItem(
            index: 0,
            icon: 'icon_garden',
            label: '가든',
          ),
          _buildTabItem(
            index: 1,
            icon: 'icon_book',
            label: '책장',
          ),
          GestureDetector(
              onTap: () => context.pushNamed('book-serach'),
              child: SizedBox(
                width: 72.w,
                child: Container(
                  alignment: Alignment.center,
                  width: 50.r,
                  height: 50.r,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.black_59,
                  ),
                  child: SvgPicture.asset(
                    '${Constant.ASSETS_ICONS}icon_add_big.svg',
                    color: Colors.white,
                    width: 28.r,
                    height: 28.r,
                  ),
                ),
              )),
          _buildTabItem(
            index: 2,
            icon: 'icon_memo',
            label: '메모',
          ),
          _buildTabItem(
            index: 3,
            icon: 'icon_user',
            label: '설정',
          )
        ],
      ),
    );
  }

  Widget _buildTabItem(
      {required int index, required String icon, required String label}) {
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Container(
        width: 52.w,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              currentIndex == index
                  ? '${Constant.ASSETS_ICONS}${icon}_fill.svg'
                  : '${Constant.ASSETS_ICONS}$icon.svg',
              width: 28.r,
              height: 28.r,
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 10.sp,
                  color: currentIndex == index
                      ? AppColors.black_59
                      : AppColors.grey_8D),
            ),
          ],
        ),
      ),
    );
  }
}
