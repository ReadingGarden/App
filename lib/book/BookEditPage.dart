import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/service/BookService.dart';
import '../utils/AppColors.dart';
import '../utils/AutoInputFormatter.dart';
import '../utils/Functions.dart';
import '../utils/Widgets.dart';

final bookReadListProvider = StateProvider<List>((ref) => []);

class BookEditPage extends ConsumerStatefulWidget {
  BookEditPage({super.key, required this.book});

  _BookEditPageState createState() => _BookEditPageState();

  final Map book;
}

class _BookEditPageState extends ConsumerState<BookEditPage> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getBookRead();
  }

  //독서 기록 조회 api
  void getBookRead() async {
    final response = await bookService.getBookRead(widget.book['book_no']);
    if (response?.statusCode == 200) {
      ref.read(bookReadListProvider.notifier).state =
          response?.data['data']['book_read_list'];

      if (ref.watch(bookReadListProvider).isNotEmpty) {
        //읽기 시작한 날
        _startController.text = Functions.formatBookReadDate(
            ref.watch(bookReadListProvider)[
                ref.watch(bookReadListProvider).length - 1]['book_start_date']);

        //다 읽은 날
        if (ref.watch(bookReadListProvider)[0]['book_end_date'] != null) {
          _endController.text = Functions.formatBookReadDate(
              ref.watch(bookReadListProvider)[0]['book_end_date']);
        }
      }
    }
  }

  //독서 기록 수정 api
  Future<bool> putBookRead(int id, Map data) async {
    final response = await bookService.putBookRead(id, data);
    if (response?.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //수정하기 버튼
  void _bookReadEdit() async {
    final bookReadList = ref.watch(bookReadListProvider);

    //첫 번째 요청: 시작 날짜 업데이트
    if (_startController.text !=
            Functions.formatBookReadDate(ref.watch(bookReadListProvider)[
                    ref.watch(bookReadListProvider).length - 1]
                ['book_start_date']) &&
        _startController.text.isNotEmpty) {
      int startId = bookReadList[bookReadList.length - 1]['id'];
      Map data = {
        "book_start_date":
            Functions.formatBookReadString(_startController.text).toString(),
      };
      await putBookRead(startId, data);
    }

    //두 번째 요청: 종료 날짜 업데이트
    if (_endController.text !=
            Functions.formatBookReadDate(
                ref.watch(bookReadListProvider)[0]['book_end_date']) &&
        (_endController.text.isNotEmpty)) {
      int endId = bookReadList[0]['id'];
      Map data = {
        "book_end_date":
            Functions.formatBookReadString(_endController.text).toString()
      };

      await putBookRead(endId, data);
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context, title: '책 수정하기'),
      body: Column(
        children: [
          Container(
              height: 88.h,
              margin: EdgeInsets.only(left: 24.w, right: 24.w),
              child: Row(children: [
                (widget.book['book_image_url'] != null &&
                        widget.book['book_image_url'] != '')
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          width: 48.w,
                          height: 64.h,
                          fit: BoxFit.cover,
                          widget.book['book_image_url'],
                        ),
                      )
                    : Container(
                        width: 48.w,
                        height: 64.h,
                        decoration: BoxDecoration(
                            color: AppColors.grey_F2,
                            borderRadius: BorderRadius.circular(8.r)),
                      ),
                Container(
                  margin: EdgeInsets.only(left: 12.w),
                  width: 252.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.book['book_title'],
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        widget.book['book_author'],
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 12.sp, color: AppColors.grey_8D),
                      ),
                    ],
                  ),
                ),
              ])),
          Container(
            height: 1.h,
            color: AppColors.grey_F2,
          ),
          Container(
            margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
            child: Column(
              children: [
                _dateTextField(
                    _startController, '읽기 시작한 날', '읽기 시작한 날짜를 알려주세요'),
                _dateTextField(_endController, '다 읽은 날', '완독한 날짜를 입력해주세요')
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
          child: Widgets.button('수정하기', true, _bookReadEdit)),
    );
  }
}

Widget _dateTextField(
    TextEditingController controller, String label, String hint) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.only(top: 6.h, bottom: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 6.h),
              height: 22.h,
              child: Text(
                label,
              ),
            ),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              maxLength: 10,
              inputFormatters: [AutoInputFormatter()],
              style: TextStyle(fontSize: 16.sp),
              decoration: InputDecoration(
                counter: Container(),
                fillColor: AppColors.grey_FA,
                filled: true,
                hintText: hint,
                hintStyle: TextStyle(fontSize: 16.sp, color: AppColors.grey_8D),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 1.w)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 1.w)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 1.w)),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
