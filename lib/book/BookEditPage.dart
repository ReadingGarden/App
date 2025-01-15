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
final startDateErrorProvider = StateProvider<String?>((ref) => null);
final endDateErrorProvider = StateProvider<String?>((ref) => null);

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

    context.pop('BookDetailPage_getBookRead');
  }

  //읽기 시작한 날 error
  void _startValidate() {
    if (_startController.text.length == 10) {
      ref.read(startDateErrorProvider.notifier).state = null;
    } else {
      ref.read(startDateErrorProvider.notifier).state = 'YYYY.MM.DD 형식으로 적어주세요';
    }
  }

  //다 읽은 날 error
  void _endValidate() {
    if (_endController.text.length == 10 || _endController.text.isEmpty) {
      ref.read(endDateErrorProvider.notifier).state = null;
    } else {
      ref.read(endDateErrorProvider.notifier).state = 'YYYY.MM.DD 형식으로 적어주세요';
    }
  }

  @override
  Widget build(BuildContext context) {
    final startErrorText = ref.watch(startDateErrorProvider);
    final endErrorText = ref.watch(endDateErrorProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '책 수정하기'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.transparent,
          child: Column(
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
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            widget.book['book_author'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                        ref,
                        _startController,
                        '읽기 시작한 날',
                        '읽기 시작한 날짜를 알려주세요',
                        startErrorText,
                        startDateErrorProvider,
                        () => _startValidate()),
                    _dateTextField(
                        ref,
                        _endController,
                        '다 읽은 날',
                        '완독한 날짜를 입력해주세요',
                        endErrorText,
                        endDateErrorProvider,
                        () => _endValidate())
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
          child: Widgets.button('수정하기', true, _bookReadEdit)),
    );
  }
}

Widget _dateTextField(
    WidgetRef ref,
    TextEditingController controller,
    String label,
    String hint,
    String? errorText,
    StateProvider<String?> errorProvider,
    Function? validateFunction) {
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
              child: Text(
                label,
              ),
            ),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              maxLength: 10,
              inputFormatters: [AutoInputFormatter()],
              onChanged: (value) {
                // errorText 초기화
                ref.read(errorProvider.notifier).state = null;
              },
              onTapOutside: (event) {
                if (validateFunction != null) {
                  validateFunction();
                }
              },
              onSubmitted: (value) {
                if (validateFunction != null) {
                  validateFunction();
                }
              },
              style: TextStyle(fontSize: 16.sp),
              decoration: InputDecoration(
                counter: const Text(''),
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
                errorText: errorText,
                errorStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.errorRedColor,
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide:
                        BorderSide(color: AppColors.errorRedColor, width: 1.w)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide:
                        BorderSide(color: AppColors.errorRedColor, width: 1.w)),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
