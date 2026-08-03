import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:book_flutter/shared/theme/app_assets.dart';
import 'package:book_flutter/shared/theme/app_colors.dart';

//별점 개수
const int kStarCount = 5;

//별점별 문구 (index 0 = 선택 전)
const List<String> kRatingTexts = [
  '이 책 어떠셨나요?',
  '끝까지 읽은 나에게 치얼스',
  '나와는 조금 안 맞았다',
  '무난하게 잘 읽었다',
  '언젠가 다시 펼쳐볼 책',
  '오늘부터 나의 인생책',
];

//보더 카드 + 별점 + 문구. 완독 화면과 책 수정 화면이 같이 쓴다
class StarRatingCard extends StatelessWidget {
  const StarRatingCard({
    super.key,
    required this.rating,
    required this.onChanged,
    this.onChangeEnd,
    this.width,
  });

  final int rating;
  final ValueChanged<int> onChanged;
  final VoidCallback? onChangeEnd;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 312.w,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.grey_F2, width: 1.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StarRatingInput(
            rating: rating,
            size: 32.r,
            gap: 4.w,
            onChanged: onChanged,
            onChangeEnd: onChangeEnd,
          ),
          Container(
            margin: EdgeInsets.only(top: 16.h),
            child: Text(
              kRatingTexts[rating],
              style: TextStyle(
                fontSize: 12.sp,
                color: rating == 0
                    ? AppColors.grey_8D
                    : AppColors.starSelectColor,
                fontWeight: rating == 0 ? FontWeight.w400 : FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//탭·드래그로 별점을 고르는 위젯
class StarRatingInput extends StatelessWidget {
  const StarRatingInput({
    super.key,
    required this.rating,
    required this.size,
    required this.gap,
    required this.onChanged,
    this.onChangeEnd,
  });

  final int rating;
  final double size;
  final double gap;

  //드래그 중에도 계속 불림
  final ValueChanged<int> onChanged;

  //손을 뗐을 때 한 번만 불림 (저장 시점용)
  final VoidCallback? onChangeEnd;

  //x좌표로 별점 계산 (첫 별 왼쪽으로 나가면 0점)
  int _ratingByPosition(double dx) {
    if (dx < 0) return 0;
    final index = (dx / (size + gap)).floor();
    return (index + 1).clamp(0, kStarCount);
  }

  //같은 별을 다시 누르면 0점으로
  void _handleTap(double dx) {
    final tapped = _ratingByPosition(dx);
    onChanged(tapped == rating ? 0 : tapped);
  }

  void _handleDrag(double dx) {
    final dragged = _ratingByPosition(dx);
    if (dragged != rating) onChanged(dragged);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (details) => _handleTap(details.localPosition.dx),
      onTapUp: (_) => onChangeEnd?.call(),
      onHorizontalDragStart: (details) => _handleDrag(details.localPosition.dx),
      onHorizontalDragUpdate: (details) =>
          _handleDrag(details.localPosition.dx),
      onHorizontalDragEnd: (_) => onChangeEnd?.call(),
      child: SizedBox(
        width: size * kStarCount + gap * (kStarCount - 1),
        child: StarRow(rating: rating, size: size, gap: gap),
      ),
    );
  }
}

//별 5개를 rating만큼 채워서 그리는 표시 전용 위젯
class StarRow extends StatelessWidget {
  const StarRow({
    super.key,
    required this.rating,
    required this.size,
    required this.gap,
  });

  final int rating;
  final double size;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: gap,
      children: List.generate(kStarCount, (index) {
        final selected = index < rating;
        return (selected ? AppAssets.iconStarSelect : AppAssets.iconStarDeselect)
            .svg(
          width: size,
          height: size,
          colorFilter: ColorFilter.mode(
            selected ? AppColors.starSelectColor : AppColors.grey_CA,
            BlendMode.srcIn,
          ),
        );
      }),
    );
  }
}
