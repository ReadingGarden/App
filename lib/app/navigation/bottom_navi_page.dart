import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../gen/assets.gen.dart';
import '../../features/book/presentation/pages/bookshelf_page.dart';
import '../../features/garden/presentation/providers/garden_provider.dart'
    as garden_feature;
import '../../features/garden/presentation/pages/garden_page.dart';
import '../../features/memo/presentation/pages/memo_page.dart';
import '../../features/mypage/presentation/pages/my_page.dart';
import 'package:book_flutter/shared/theme/app_colors.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class BottomNaviPage extends ConsumerWidget {
  const BottomNaviPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    return Scaffold(
      backgroundColor: (ref.read(currentIndexProvider.notifier).state == 0)
          ? const Color(0xffA4BC8A)
          : Colors.white,
      body: IndexedStack(
        index: currentIndex,
        children: const [GardenPage(), BookShelfPage(), MemoPage(), MyPage()],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTabSelected: (index) {
          ref.read(currentIndexProvider.notifier).state = index;
          if (ref.read(currentIndexProvider.notifier).state == 0) {
            garden_feature.fetchGardenList(ref);
            ref.read(garden_feature.gardenVisitCountProvider.notifier).state++;
          }
        },
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return Container(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: bottomPadding),
      height: 70.h + bottomPadding,
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
                  child: Assets.icons.iconAddBig.svg(
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
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

  Widget _buildTabItem({
    required int index,
    required String icon,
    required String label,
  }) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Container(
        width: 52.w,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _AnimatedTabIcon(
              isSelected: isSelected,
              child: _iconAsset(index).svg(
                width: 28.r,
                height: 28.r,
                colorFilter: (index != 3)
                    ? const ColorFilter.mode(
                        AppColors.black_59,
                        BlendMode.srcIn,
                      )
                    : null,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 10.sp,
                  color: isSelected
                      ? AppColors.black_59
                      : AppColors.grey_8D),
            ),
          ],
        ),
      ),
    );
  }

  SvgGenImage _iconAsset(int index) {
    switch (index) {
      case 0:
        return currentIndex == index
            ? Assets.icons.iconGardenFill
            : Assets.icons.iconGarden;
      case 1:
        return currentIndex == index
            ? Assets.icons.iconBookFill
            : Assets.icons.iconBook;
      case 2:
        return currentIndex == index
            ? Assets.icons.iconMemoFill
            : Assets.icons.iconMemo;
      case 3:
        return currentIndex == index
            ? Assets.icons.iconUserFill
            : Assets.icons.iconUser;
      default:
        return Assets.icons.iconGarden;
    }
  }
}

class _AnimatedTabIcon extends StatefulWidget {
  const _AnimatedTabIcon({
    required this.isSelected,
    required this.child,
  });

  final bool isSelected;
  final Widget child;

  @override
  State<_AnimatedTabIcon> createState() => _AnimatedTabIconState();
}

class _AnimatedTabIconState extends State<_AnimatedTabIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.25), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.25, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(_AnimatedTabIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: widget.child,
    );
  }
}
