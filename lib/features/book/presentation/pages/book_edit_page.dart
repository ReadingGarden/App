import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:book_flutter/shared/utils/functions.dart';
import 'package:book_flutter/shared/utils/auto_input_formatter.dart';
import 'package:book_flutter/shared/theme/app_colors.dart';
import 'package:book_flutter/shared/widgets/app_widgets.dart';
import 'package:book_flutter/features/book/domain/entities/book_edit_input_entity.dart';
import 'package:book_flutter/features/book/presentation/providers/book_edit_provider.dart';

final startDateErrorProvider = StateProvider<String?>((ref) => null);
final endDateErrorProvider = StateProvider<String?>((ref) => null);

class BookEditPage extends ConsumerStatefulWidget {
  const BookEditPage({super.key, required this.book});

  @override
  ConsumerState<BookEditPage> createState() => _BookEditPageState();

  final BookEditInputEntity book;
}

class _BookEditPageState extends ConsumerState<BookEditPage> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchBookReadList(ref, widget.book.bookNo).then((_) {
      final bookReadList = ref.read(bookReadListProvider);
      if (bookReadList.isNotEmpty) {
        _startController.text = Functions.formatBookReadDate(
          bookReadList.last.bookStartDate!,
        );

        if (bookReadList.first.bookEndDate != null) {
          _endController.text = Functions.formatBookReadDate(
            bookReadList.first.bookEndDate!,
          );
        }
      }
    });
  }

  //수정하기 버튼
  void _bookReadEdit() async {
    final bookReadList = ref.watch(bookReadListProvider);
    await updateBookReadDates(
      ref,
      bookReadList: bookReadList,
      startDate: _startController.text,
      endDate: _endController.text,
    );

    if (!mounted) return;
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
                    (widget.book.bookImageUrl != null &&
                            widget.book.bookImageUrl != '')
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              width: 48.w,
                              height: 64.h,
                              fit: BoxFit.cover,
                              widget.book.bookImageUrl!,
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
                            widget.book.bookTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            widget.book.bookAuthor,
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
      bottomNavigationBar: Widgets.bottomBar(context,
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
