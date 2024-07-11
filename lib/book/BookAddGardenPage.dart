import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../core/service/BookService.dart';
import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

final buttonCheckProvider = StateProvider<bool>((ref) => false);
final detailIsbnProvider = StateProvider<Map>((ref) => {});

class BookAddGardenPage extends ConsumerStatefulWidget {
  _BookAddGardenPageState createState() => _BookAddGardenPageState();
}

class _BookAddGardenPageState extends ConsumerState<BookAddGardenPage> {
  @override
  void initState() {
    super.initState();
    getDetailBook_ISBN('9788932916194');
  }

  //책 상세조회 isbn api
  void getDetailBook_ISBN(String isbn) async {
    final response = await bookService.getDetailBook_ISBN(isbn);
    if (response?.statusCode == 200) {
      ref.read(detailIsbnProvider.notifier).state = response?.data['data'];
    } else if (response?.statusCode == 400) {
      print('토큰에러');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Widgets.appBar(context),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 60.h),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 312.w,
                  height: 307.h,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          width: 122.w,
                          height: 180.h,
                          fit: BoxFit.cover,
                          ref.watch(detailIsbnProvider)['cover'],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 29.h, bottom: 6.h),
                        child: Text(
                          ref.watch(detailIsbnProvider)['title'],
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ),
                      Text(
                        ref.watch(detailIsbnProvider)['author'],
                        style: TextStyle(
                            fontSize: 12.sp, color: AppColors.grey_8D),
                      ),
                      Text(
                        ref.watch(detailIsbnProvider)['publisher'],
                        style: TextStyle(
                            fontSize: 12.sp, color: AppColors.grey_8D),
                      ),
                      Text(
                        '${ref.watch(detailIsbnProvider)['itemPage']}p',
                        style: TextStyle(
                            fontSize: 12.sp, color: AppColors.grey_8D),
                      ),
                    ],
                  ),
                ),
                (!ref.watch(buttonCheckProvider))
                    ? GestureDetector(
                        onTap: () {
                          ref.read(buttonCheckProvider.notifier).state = true;
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 20.h, bottom: 30.h),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          width: 93.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.r),
                              border:
                                  Border.all(color: AppColors.primaryColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 12.r,
                                height: 12.r,
                                child: SvgPicture.asset(
                                  'assets/images/plus.svg',
                                ),
                              ),
                              Text(
                                '읽고싶어요',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor),
                              )
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          ref.read(buttonCheckProvider.notifier).state = false;
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 20.h, bottom: 30.h),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          width: 93.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: AppColors.primaryColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 12.r,
                                height: 12.r,
                                child: SvgPicture.asset(
                                  'assets/images/check.svg',
                                ),
                              ),
                              Text(
                                '읽고싶어요',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                Container(
                  padding: EdgeInsets.only(
                      top: 20.h, bottom: 20.h, left: 24.w, right: 24.w),
                  width: 312.w,
                  // height: 210.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: AppColors.grey_F2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        height: 22.h,
                        child: const Text(
                          '책 소개',
                          style: TextStyle(color: AppColors.grey_8D),
                        ),
                      ),
                      Text(
                        ref.watch(detailIsbnProvider)['description'],
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
            margin: EdgeInsets.only(
                left: 24.w, right: 24.w, bottom: 30.h, top: 10.h),
            child: Widgets.button('내 가든에 심기', true, () {})));
  }
}
