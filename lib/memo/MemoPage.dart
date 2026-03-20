import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../features/memo/presentation/providers/memo_list_provider.dart'
    as memo_feature;
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Functions.dart';

class MemoPage extends ConsumerStatefulWidget {
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends ConsumerState<MemoPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      memo_feature.refreshMemoList(ref);
    });

    _scrollController.addListener(() {
      // 스크롤이 마지막에 도달했을 때 추가 데이터를 로드
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        memo_feature.fetchMemoList(ref, scroll: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final memoList = ref.watch(memo_feature.memoListStateProvider);
    final isLoading = ref.watch(memo_feature.memoListLoadingProvider);

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.h,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          leadingWidth: 0,
          leading: Container(),
          centerTitle: false,
          titleSpacing: 24.w,
          title: Text(
            '메모',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                final result = await context.pushNamed('memo-book');
                if (result != null) {
                  memo_feature.refreshMemoList(ref);
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: 60.r,
                height: 60.r,
                color: Colors.transparent,
                child: SvgPicture.asset(
                  '${Constant.ASSETS_ICONS}icon_write.svg',
                  width: 24.r,
                  height: 24.r,
                ),
              ),
            )
          ],
        ),
        body: (isLoading && memoList.isEmpty)
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.primaryColor,
                  color: AppColors.grey_CA,
                ),
              )
            : (memoList.isNotEmpty)
                ? _memoList(memoList)
                : _memoEmpty());
  }

  Widget _memoList(memoList) {
    return RefreshIndicator(
      onRefresh: () async {
        memo_feature.refreshMemoList(ref);
      },
      backgroundColor: Colors.white,
      color: AppColors.grey_8D,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        children: List.generate(
          memoList.length,
          (index) {
            final memo = memoList[index];
            return GestureDetector(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final result =
                          await context.pushNamed('memo-detail', extra: memo.toMap());
                      if (result != null) {
                        memo_feature.refreshMemoList(ref);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
                      width: 312.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey_F2),
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.transparent),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              (memo.bookImageUrl == null)
                                  ? Container(
                                      width: 44.r,
                                      height: 44.r,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: AppColors.grey_F2),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.network(
                                        width: 44.r,
                                        height: 44.r,
                                        fit: BoxFit.cover,
                                        memo.bookImageUrl!,
                                      ),
                                    ),
                              Container(
                                width: 212.w,
                                margin: EdgeInsets.only(left: 12.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      memo.bookTitle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      memo.bookAuthor,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.grey_8D),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Visibility(
                              visible: memo.imageUrl != null,
                              child: Container(
                                margin: EdgeInsets.only(top: 10.h),
                                child: Image.network(
                                    width: 320.w,
                                    height: 140.h,
                                    fit: BoxFit.fitWidth,
                                    '${Constant.IMAGE_URL}${memo.imageUrl}'),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 10.h),
                              child: Text(
                                memo.memoContent,
                                maxLines: 5,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    overflow: TextOverflow.ellipsis,
                                    height: 1.75.h),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 10.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Functions.formatDate(memo.memoCreatedAt),
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.grey_8D),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      memo_feature.toggleMemoLike(ref, index, memo.id);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 10.w, bottom: 20.h),
                      width: 40.r,
                      height: 40.r,
                      color: Colors.transparent,
                      child: SvgPicture.asset(
                        memo.memoLike
                            ? '${Constant.ASSETS_ICONS}icon_star_select.svg'
                            : '${Constant.ASSETS_ICONS}icon_star_deselect.svg',
                        color: memo.memoLike
                            ? AppColors.starYellowColor
                            : AppColors.grey_CA,
                        width: 20.r,
                        height: 20.r,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _memoEmpty() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 120.h),
      child: Column(
        children: [
          SizedBox(
              width: 200.r,
              height: 200.r,
              child: Image.asset('assets/images/empty/empty_메모.png')),
          Container(
            margin: EdgeInsets.only(top: 16.h, bottom: 6.h),
            child: Text(
              '메모를 작성해보세요',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ),
          const Text(
            '지금 읽고 있는 책이 있나요?\n책을 추가하고 가든을 가꿔보세요',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.grey_8D),
          ),
        ],
      ),
    );
  }
}
