import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/service/BookService.dart';
import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

final bookSerachListProvider = StateProvider<List>((ref) => []);
final bookTotalCountProvider = StateProvider<int>((ref) => 0);

class BookSerachPage extends ConsumerStatefulWidget {
  _BookSerachPageState createState() => _BookSerachPageState();
}

class _BookSerachPageState extends ConsumerState<BookSerachPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(bookSerachListProvider.notifier).state = [];
      ref.read(bookTotalCountProvider.notifier).state = 0;
    });
  }

  //책 검색 api
  void getSearchBook(String query) async {
    final response = await bookService.getSerachBook(query);
    if (response?.statusCode == 200) {
      ref.read(bookSerachListProvider.notifier).state =
          response?.data['data']['item'];
      ref.read(bookTotalCountProvider.notifier).state =
          response?.data['data']['totalResults'];
    } else if (response?.statusCode == 400) {
      print('토큰에러');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 20.h, bottom: 120.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 24.w),
                  child: Text(
                    '책 추가하기',
                    style:
                        TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      margin:
                          EdgeInsets.only(top: 20.h, left: 24.w, right: 24.w),
                      alignment: Alignment.center,
                      height: 72.h,
                      child: TextField(
                        controller: _textEditingController,
                        onSubmitted: (value) {
                          getSearchBook(value);
                        },
                        style: TextStyle(fontSize: 16.sp),
                        decoration: InputDecoration(
                            prefixIcon: Container(
                              alignment: Alignment.center,
                              width: 20.r,
                              height: 20.r,
                              child: SvgPicture.asset(
                                'assets/images/search.svg',
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10.r)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10.r)),
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10.r)),
                            fillColor: AppColors.grey_FA,
                            filled: true,
                            hintText: '제목, 작가 명으로 검색',
                            hintStyle: TextStyle(
                                fontSize: 16.sp, color: AppColors.grey_8D)),
                      )),
                ),
                (ref.watch(bookSerachListProvider).isNotEmpty)
                    ? _serachList(_textEditingController.text)
                    : Column(
                        children: [
                          GestureDetector(
                            onTap: () => context.pushNamed('book-user-write'),
                            child: Container(
                                alignment: Alignment.center,
                                height: 72.h,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      EdgeInsets.only(left: 24.w, right: 22.w),
                                  width: 312.w,
                                  height: 64.h,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.grey_F2),
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: Colors.transparent),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '책 직접 입력하기',
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: AppColors.primaryColor),
                                      ),
                                      SvgPicture.asset(
                                        'assets/images/angle-right-b.svg',
                                        width: 20.r,
                                        height: 20.r,
                                        color: AppColors.primaryColor,
                                      )
                                    ],
                                  ),
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('바코드 카메라 열어라');
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 72.h,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      EdgeInsets.only(left: 24.w, right: 22.w),
                                  width: 312.w,
                                  height: 64.h,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.grey_F2),
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: Colors.transparent),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '바코드로 검색하기',
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: AppColors.primaryColor),
                                      ),
                                      SvgPicture.asset(
                                        'assets/images/angle-right-b.svg',
                                        width: 20.r,
                                        height: 20.r,
                                        color: AppColors.primaryColor,
                                      )
                                    ],
                                  ),
                                )),
                          )
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _serachList(String value) {
    return SizedBox(
      height: (24 * 88.h) + 42.h, //(itemcount * listcontainer) + titleContainer
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 22.h,
              margin: EdgeInsets.only(left: 24.w, top: 10.h, bottom: 10.h),
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: '\'$value\' ',
                    style: const TextStyle(color: AppColors.grey_8D)),
                TextSpan(
                    text: ref.watch(bookTotalCountProvider).toString(),
                    style: TextStyle(color: AppColors.primaryColor))
              ]))),
          Expanded(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                ref.watch(bookSerachListProvider).length,
                (index) {
                  return GestureDetector(
                    onTap: () => context.pushNamed('book-add-garden'),
                    child: Container(
                      padding: EdgeInsets.only(left: 24.w, right: 24.w),
                      height: 88.h,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              width: 48.w,
                              height: 64.h,
                              fit: BoxFit.cover,
                              ref.watch(bookSerachListProvider)[index]['cover'],
                            ),
                          ),
                          SizedBox(
                            width: 252.w,
                            height: 50.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ref.watch(bookSerachListProvider)[index]
                                      ['title'],
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  '${ref.watch(bookSerachListProvider)[index]['author']}',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.grey_8D,
                                      overflow: TextOverflow.ellipsis),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
