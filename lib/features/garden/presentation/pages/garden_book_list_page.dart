import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:book_flutter/shared/theme/app_assets.dart';
import 'package:book_flutter/shared/theme/app_colors.dart';
import 'package:book_flutter/shared/widgets/app_widgets.dart';
import 'package:book_flutter/features/garden/presentation/providers/garden_provider.dart'
    as garden_feature;

class GardenBookListPage extends ConsumerStatefulWidget {
  const GardenBookListPage({super.key, required this.gardenNo});

  final int gardenNo;

  @override
  ConsumerState<GardenBookListPage> createState() => _GardenBookListPageState();
}

class _GardenBookListPageState extends ConsumerState<GardenBookListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _listAnimController;
  int _prevBookCount = 0;

  @override
  void initState() {
    super.initState();
    _listAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    Future.microtask(() {
      garden_feature.fetchGardenDetail(ref, widget.gardenNo);
    });
  }

  @override
  void dispose() {
    _listAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookList = ref.watch(garden_feature.gardenMainBookListProvider);

    if (bookList.length != _prevBookCount && bookList.isNotEmpty && mounted) {
      _prevBookCount = bookList.length;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _listAnimController.forward(from: 0);
      });
    }

    return Scaffold(
      appBar: Widgets.appBar(context,
          title: ref.watch(garden_feature.gardenMainProvider).gardenTitle),
      body: RefreshIndicator(
        onRefresh: () async {
          await garden_feature.fetchGardenDetail(ref, widget.gardenNo);
        },
        backgroundColor: Colors.white,
        color: AppColors.grey_8D,
        child: ListView(
          // 스크롤이 항상 가능하도록 설정
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.h, left: 24.w, right: 24.w),
              // height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('책 ${bookList.length}권',
                      style: const TextStyle(color: AppColors.grey_8D)),
                  (bookList.isNotEmpty)
                      ? Container(
                          margin: EdgeInsets.only(top: 18.h),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio:
                                  MediaQuery.of(context).size.aspectRatio /
                                      0.85,
                              crossAxisCount: 3,
                              crossAxisSpacing: 12.w,
                            ),
                            itemCount: bookList.length,
                            itemBuilder: (context, index) {
                              final book = bookList[index];
                              final delay = (index * 0.05).clamp(0.0, 0.7);
                              final end = (delay + 0.3).clamp(0.0, 1.0);
                              final animation = CurvedAnimation(
                                parent: _listAnimController,
                                curve: Interval(delay, end,
                                    curve: Curves.easeOut),
                              );
                              return AnimatedBuilder(
                                animation: animation,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: animation.value,
                                    child: Transform.translate(
                                      offset:
                                          Offset(0, 16 * (1 - animation.value)),
                                      child: child,
                                    ),
                                  );
                                },
                                child: Pressable(
                                onTap: () {
                                  context.pushNamed('book-detail',
                                      extra: book.bookNo);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Container(
                                            decoration:
                                                BoxDecoration(boxShadow: [
                                              BoxShadow(
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 16.r,
                                                  color: AppColors.black_59
                                                      .withValues(alpha: 0.1))
                                            ]),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                child: (book.bookImageUrl
                                                        .isNotEmpty)
                                                    ? Image.network(
                                                        width: 96.w,
                                                        height: 132.h,
                                                        fit: BoxFit.cover,
                                                        book.bookImageUrl,
                                                      )
                                                    : Container(
                                                        width: 96.w,
                                                        height: 132.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                          color:
                                                              AppColors.grey_F2,
                                                        ),
                                                      )),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            margin:
                                                EdgeInsets.only(bottom: 10.h),
                                            width: 50.w,
                                            height: 28.h,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(20.r),
                                                  bottomLeft:
                                                      Radius.circular(20.r),
                                                ),
                                                color: (book.percent == 100)
                                                    ? AppColors.black_59
                                                    : Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset:
                                                          const Offset(0, 4),
                                                      blurRadius: 16.r,
                                                      color: AppColors.black_59
                                                          .withValues(alpha: 0.1))
                                                ]),
                                            child: Text(
                                              '${book.percent.floor()}%',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: (book.percent == 100)
                                                      ? Colors.white
                                                      : AppColors.black_59),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(top: 8.h),
                                          width: 96.w,
                                          height: 20.h,
                                          child: Text(
                                            book.bookTitle,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              );
                            },
                          ))
                      : _bookEmpty()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bookEmpty() {
    return EmptyBounce(
      delay: const Duration(milliseconds: 80),
      intensity: 1.4,
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 78.h),
          child: Column(
            children: [
              SizedBox(
                  width: 200.r,
                  height: 200.r,
                  child: AppAssets.emptyGardenBookList.image()),
              Container(
                margin: EdgeInsets.only(top: 16.h, bottom: 6.h),
                child: Text(
                  '저장된 책이 없어요',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ),
              const Text(
                '지금 읽고 있는 책이 있나요?\n책을 추가하고 가든을 가꿔보세요',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.grey_8D),
              ),
            ],
          )),
    );
  }
}

