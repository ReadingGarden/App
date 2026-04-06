import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:book_flutter/shared/theme/app_assets.dart';
import 'package:book_flutter/shared/widgets/app_widgets.dart';
import 'package:book_flutter/features/memo/domain/entities/memo_list_item_entity.dart';
import 'package:book_flutter/features/memo/presentation/providers/memo_detail_provider.dart'
    as memo_detail_feature;
import 'package:book_flutter/shared/constants/app_constant.dart';
import 'package:book_flutter/shared/theme/app_colors.dart';

class MemoDetailPage extends ConsumerStatefulWidget {
  const MemoDetailPage({super.key, required this.memo});

  final MemoListItemEntity memo;

  @override
  ConsumerState<MemoDetailPage> createState() => _MemoDetailPageState();
}

class _MemoDetailPageState extends ConsumerState<MemoDetailPage> {
  void _openMemoEdit() async {
    final result =
        await context.pushNamed('memo-update', extra: widget.memo.toMap());
    if (result != null && mounted) {
      context.pop(result);
    }
  }

  //메모 삭제 api
  void deleteMemo() async {
    final deleted = await memo_detail_feature.deleteMemo(ref, widget.memo.id);
    if (deleted) {
      if (!mounted) return;
      context.pop();
      context.pop('MemoPage_getMemoList');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Widgets.appBar(context, actions: [
          GestureDetector(
            onTap: () {
              _moreBottomSheet();
            },
            child: Container(
              alignment: Alignment.center,
              width: 60.r,
              height: 60.r,
              child: AppAssets.iconEllipsis.svg(width: 24.r, height: 24.r),
            ),
          )
        ]),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 88.h,
              margin: EdgeInsets.only(left: 24.w, right: 24.w),
              child: Row(
                children: [
                  (widget.memo.bookImageUrl == null)
                      ? Container(
                          width: 48.w,
                          height: 64.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.grey_F2),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: CachedNetworkImage(
                            imageUrl: widget.memo.bookImageUrl!,
                            width: 48.w,
                            height: 64.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                  Container(
                    width: 252.w,
                    margin: EdgeInsets.only(left: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.memo.bookTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          widget.memo.bookAuthor,
                          style: TextStyle(
                              fontSize: 12.sp, color: AppColors.grey_8D),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 1.h,
              color: AppColors.grey_F2,
            ),
            Container(
              margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 100.h),
              child: Column(
                children: [
                  Visibility(
                    visible: widget.memo.imageUrl != null,
                    child: Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: CachedNetworkImage(
                          imageUrl: '${Constant.IMAGE_URL}${widget.memo.imageUrl}',
                          width: 320.w),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 20.h),
                    child: Text(
                      widget.memo.memoContent,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 14.sp, height: 1.7.h),
                    ),
                  )
                ],
              ),
            )
          ]),
        ));
  }

  Future _moreBottomSheet() {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(top: 20.h, bottom: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                    _openMemoEdit();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 312.w,
                    height: 26.h,
                    color: Colors.transparent,
                    child: Text(
                      '메모 수정하기',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  height: 1.h,
                  color: AppColors.grey_F2,
                ),
                GestureDetector(
                  onTap: () {
                    context.pop();
                    Widgets.deleteBottomSheet(context, '이 메모를 삭제할까요?',
                        const Text('한번 삭제된 메모는 다시 되돌릴 수없어요.'), '삭제하기', () {
                      deleteMemo();
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 312.w,
                    height: 26.h,
                    color: Colors.transparent,
                    child: Text(
                      '메모 삭제하기',
                      style: TextStyle(
                          fontSize: 16.sp, color: AppColors.errorRedColor),
                    ),
                  ),
                )
              ],
            ),
        );
      },
    );
  }
}
