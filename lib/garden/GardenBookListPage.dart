import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/api/GardenAPI.dart';
import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

class GardenBookListPage extends ConsumerStatefulWidget {
  GardenBookListPage({required this.garden});

  final Map garden;

  _GardenBookListPageState createState() => _GardenBookListPageState();
}

class _GardenBookListPageState extends ConsumerState<GardenBookListPage> {
  @override
  void initState() {
    super.initState();

    final gardenAPI = GardenAPI(ref);

    Future.microtask(() {
      gardenAPI.getGardenDetail(widget.garden['garden_no']);
    });
  }

  @override
  Widget build(BuildContext context) {
    final gardenAPI = GardenAPI(ref);

    final List bookList = gardenAPI.gardenMainBookList();

    return Scaffold(
      appBar: Widgets.appBar(context, title: widget.garden['garden_title']),
      body: RefreshIndicator(
        onRefresh: () async {
          gardenAPI.getGardenDetail(widget.garden['garden_no']);
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
                                    crossAxisSpacing: 12.w,
                                    crossAxisCount: 3,
                                    childAspectRatio: 0.5),
                            itemCount: bookList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  context.pushNamed('book-detail',
                                      extra: bookList[index]['book_no']);
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
                                                  color: AppColors.black_4A
                                                      .withOpacity(0.1))
                                            ]),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                child: (bookList[index][
                                                            'book_image_url'] !=
                                                        null)
                                                    ? Image.network(
                                                        width: 96.w,
                                                        height: 132.h,
                                                        fit: BoxFit.cover,
                                                        bookList[index]
                                                            ['book_image_url'],
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
                                                color: (bookList[index]
                                                            ['percent'] ==
                                                        100)
                                                    ? AppColors.black_4A
                                                    : Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset:
                                                          const Offset(0, 4),
                                                      blurRadius: 16.r,
                                                      color: AppColors.black_4A
                                                          .withOpacity(0.1))
                                                ]),
                                            child: Text(
                                              '${bookList[index]['percent'].floor()}%',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: (bookList[index]
                                                              ['percent'] ==
                                                          100)
                                                      ? Colors.white
                                                      : AppColors.black_4A),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(top: 8.h),
                                          width: 96.w,
                                          height: 20.h,
                                          child: Text(
                                            bookList[index]['book_title'],
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ))
                                    ],
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
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 78.h),
        child: Column(
          children: [
            Container(
              width: 200.r,
              height: 200.r,
              color: Colors.green,
            ),
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
        ));
  }
}
