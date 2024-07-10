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
      // alignment: Alignment.center,
      height: 82.h,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: const Color(0xffF1F1F1)),
          //TODOL - 수정
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTabItem(
            index: 0,
            icon: Icons.home,
            label: 'Home',
          ),
          _buildTabItem(
            index: 1,
            icon: Icons.book,
            label: 'Bookshelf',
          ),
          GestureDetector(
              onTap: () => context.pushNamed('book-serach'),
              child: Container(
                width: 49.r,
                height: 49.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
              )),
          _buildTabItem(
            index: 2,
            icon: Icons.memory,
            label: 'Memo',
          ),
          _buildTabItem(
            index: 3,
            icon: Icons.person,
            label: 'MyPage',
          )
        ],
      ),
    );
  }

  Widget _buildTabItem(
      {required int index, required IconData icon, required String label}) {
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: currentIndex == index ? Colors.blue : Colors.grey,
            ),
            Text(
              label,
              style: TextStyle(
                  color: currentIndex == index ? Colors.blue : Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
