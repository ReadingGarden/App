import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

class GardenBookListPage extends ConsumerStatefulWidget {
  GardenBookListPage({required this.garden});

  final Map garden;

  _GardenBookListPageState createState() => _GardenBookListPageState();
}

class _GardenBookListPageState extends ConsumerState<GardenBookListPage> {
  @override
  Widget build(BuildContext context) {
    final List bookList = widget.garden['book_list'];

    return Scaffold(
      appBar: Widgets.appBar(context, title: widget.garden['garden_title']),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20.h, left: 24.w, right: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('책 ${widget.garden['book_list'].length}권',
                  style: const TextStyle(color: AppColors.grey_8D)),
              (widget.garden['book_list'] != [])
                  ? Container(
                      margin: EdgeInsets.only(top: 18.h),
                      child: GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 12.w,
                            crossAxisCount: 3,
                            childAspectRatio: 0.5),
                        children: List.generate(
                          bookList.length,
                          (index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Container(
                                      height: 142.h,
                                      color: Colors.grey,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(bottom: 10.h),
                                      width: 50.w,
                                      height: 28.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.r),
                                          bottomLeft: Radius.circular(20.r),
                                        ),
                                        color:
                                            (bookList[index]['percent'] == 100)
                                                ? AppColors.black_4A
                                                : AppColors.grey_F2,
                                      ),
                                      child: Text(
                                        '${bookList[index]['percent']}%',
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
                                          overflow: TextOverflow.ellipsis),
                                    ))
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  : _bookEmpty()
            ],
          ),
        ),
      ),
    );
  }

  Widget _bookEmpty() {
    return Container();
  }
}
