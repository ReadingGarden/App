import 'package:book_flutter/book/BookAddPage.dart';
import 'package:book_flutter/book/BookshelfPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'garden/GardenPage.dart';
import 'memo/MemoPage.dart';
import 'mypage/MyPage.dart';
import 'utils/AppColors.dart';

//현재 선택된 인덱스를 관리하는 ...
final currentIndexProvider = StateProvider<int>((ref) => 0);

class BottomNaviPage extends ConsumerWidget {
  const BottomNaviPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //현재 선택된 인덱스를 watch
    final currentIndex = ref.watch(currentIndexProvider);

    return Scaffold(
      backgroundColor: Colors.green,
      body: IndexedStack(
        index: currentIndex,
        children: [GardenPage(), BookShelfPage(), MemoPage(), MyPage()],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTabSelected: (index) {
          //선택된 인덱스를 업데이트
          ref.read(currentIndexProvider.notifier).state = index;
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
      height: 82.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTabItem(
            index: 0,
            icon: Icons.home,
            label: '가든',
          ),
          _buildTabItem(
            index: 1,
            icon: Icons.book,
            label: '책장',
          ),
          GestureDetector(
              onTap: () => context.pushNamed('book-serach'),
              child: SizedBox(
                width: 72.w,
                child: Container(
                  width: 50.r,
                  height: 50.r,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.black_4A,
                  ),
                ),
              )),
          _buildTabItem(
            index: 2,
            icon: Icons.memory,
            label: '메모',
          ),
          _buildTabItem(
            index: 3,
            icon: Icons.person,
            label: '설정',
          )
        ],
      ),
    );
  }

  Widget _buildTabItem(
      {required int index, required IconData icon, required String label}) {
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Container(
        width: 52.w,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: currentIndex == index
                  ? AppColors.black_4A
                  : AppColors.grey_CA,
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 10.sp,
                  color: currentIndex == index
                      ? AppColors.black_4A
                      : AppColors.grey_8D),
            ),
          ],
        ),
      ),
    );
  }
}
