import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/service/MemoService.dart';
import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

//완료 버튼 상태를 관리하는 ...
final okButtonProvider = StateProvider<bool>((ref) => false);

class MemoWritePage extends ConsumerStatefulWidget {
  const MemoWritePage({required this.book});

  final Map book;

  @override
  _MemoBookPageState createState() => _MemoBookPageState();
}

class _MemoBookPageState extends ConsumerState<MemoWritePage> {
  final TextEditingController _memoController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(okButtonProvider.notifier).state = false;
    });
  }

  void postMemo() async {
    Map data = {
      "book_no": widget.book['book_no'],
      "memo_content": _memoController.text,
      "memo_quote": "" //인용
    };
    //TODO - 이미지 추가
    final response = await memoService.postMemo(data);
    if (response?.statusCode == 201) {
      context.pop();
      context.pop('MemoPage_getMemoList');
    }
  }

  @override
  Widget build(BuildContext context) {
    final okButtonBool = ref.watch(okButtonProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '메모 작성하기', actions: [
        GestureDetector(
          onTap: () {
            if (okButtonBool) {
              postMemo();
            }
          },
          child: Container(
            margin: EdgeInsets.only(right: 24.w),
            height: 24.h,
            child: Text(
              '완료',
              style: TextStyle(
                  fontSize: 16.sp,
                  color: (okButtonBool)
                      ? AppColors.primaryColor
                      : AppColors.grey_8D),
            ),
          ),
        )
      ], backFunction: () {
        Widgets.baseBottomSheet(context, '메모가 저장되지 않았어요!',
            '작성하던 메모를 삭제하고 이전 페이지로 돌아가시겠어요?', '삭제하고 나가기', () {
          context.pop();
          context.pop();
          context.pop();
        });
      }),
      body: GestureDetector(
        onTap: () {
          // 키보드 내리기
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 88.h,
              margin: EdgeInsets.only(left: 24.w, right: 24.w),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 64.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.green),
                  ),
                  Container(
                    height: 50.h,
                    margin: EdgeInsets.only(left: 12.w),
                    child: Column(
                      //TODO: - 간격 수정
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // widget.memo['']
                          widget.book['book_title'],
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          widget.book['book_author'],
                          style: TextStyle(
                              fontSize: 14.sp, color: AppColors.grey_8D),
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
              margin: EdgeInsets.only(left: 24.w, right: 24.w),
              child: Column(
                children: [
                  Visibility(
                    visible: true,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.h),
                          height: 165.h,
                          color: Colors.green,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(right: 10.w, bottom: 10.h),
                            child: SvgPicture.asset(
                              'assets/images/photo-delete_btn.svg',
                              width: 30.r,
                              height: 30.r,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: TextField(
                          controller: _memoController,
                          focusNode: _focusNode,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              ref.read(okButtonProvider.notifier).state = true;
                            } else {
                              ref.read(okButtonProvider.notifier).state = false;
                            }
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  '책에 대해 적어보세요.\n생각, 느낌, 독서 환경 등 뭐든 상관 없어요!',
                              hintMaxLines: 2,
                              hintStyle: TextStyle(color: AppColors.grey_8D))))
                ],
              ),
            )
          ]),
        ),
      ),
      bottomSheet: Container(
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h, bottom: 4.h),
        height: 38.h,
        color: AppColors.grey_F2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                (!true)
                    ? GestureDetector(
                        onTap: () {
                          print('사진');
                        },
                        child: SvgPicture.asset(
                          'assets/images/camera.svg',
                          width: 30.r,
                          height: 30.r,
                        ),
                      )
                    : SvgPicture.asset(
                        'assets/images/camera.svg',
                        color: AppColors.grey_CA,
                        width: 30.r,
                        height: 30.r,
                      ),
                (!true)
                    ? GestureDetector(
                        onTap: () {
                          print('갤');
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10.w),
                          color: Colors.transparent,
                          child: SvgPicture.asset(
                            'assets/images/photo.svg',
                            width: 30.r,
                            height: 30.r,
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(left: 10.w),
                        color: Colors.transparent,
                        child: SvgPicture.asset(
                          'assets/images/photo.svg',
                          color: AppColors.grey_CA,
                          width: 30.r,
                          height: 30.r,
                        ),
                      ),
              ],
            ),
            GestureDetector(
              onTap: () {
                if (FocusScope.of(context).hasFocus) {
                  // 키보드 내리기
                  FocusScope.of(context).unfocus();
                } else {
                  FocusScope.of(context).requestFocus(_focusNode);
                }
              },
              child: SvgPicture.asset(
                (!FocusScope.of(context).hasFocus)
                    ? 'assets/images/keyboard-hide.svg'
                    : 'assets/images/keyboard-live.svg',
                width: 30.r,
                height: 30.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
