import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../core/service/MemoService.dart';
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Widgets.dart';

//완료 버튼 상태를 관리하는 ...
final okButtonProvider = StateProvider<bool>((ref) => false);
//이미지 파일 상태를 관리하는 ... (이미지 피커)
final memoImageFileProvider = StateProvider<XFile?>((ref) => null);
//이미지 존재 상태를 관리하는 ...
final memoImageNameProvider = StateProvider<String?>((ref) => null);
//수정시 기존 이미지 삭제한 경우를 관리하는 ... (이미지 네트워크 -> 갤러리)
final memoImageUpdateProvider = StateProvider<bool>((ref) => true);

class MemoWritePage extends ConsumerStatefulWidget {
  const MemoWritePage({required this.book});

  final Map book;

  @override
  _MemoBookPageState createState() => _MemoBookPageState();
}

class _MemoBookPageState extends ConsumerState<MemoWritePage> {
  final TextEditingController _memoController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(okButtonProvider.notifier).state = false;
      ref.read(memoImageFileProvider.notifier).state = null;
      ref.read(memoImageNameProvider.notifier).state = null;
      ref.read(memoImageUpdateProvider.notifier).state = true;

      //메모 정보 있을 때 (수정시)
      if (widget.book['id'] != null) {
        _memoController.text = widget.book['memo_content'];
        ref.read(okButtonProvider.notifier).state = true;
        ref.read(memoImageNameProvider.notifier).state =
            widget.book['image_url'];
        ref.read(memoImageUpdateProvider.notifier).state = false;
      }
    });
  }

  //메모 작성하기 api
  void postMemo() async {
    Map data = {
      "book_no": widget.book['book_no'],
      "memo_content": _memoController.text,
      // "memo_quote": "" //인용
    };
    final response = await memoService.postMemo(data);
    if (response?.statusCode == 201) {
      if (ref.watch(memoImageFileProvider) != null) {
        postMemoImage(response?.data['data']['id']);
      } else {
        context.pop();
        context.pop('MemoPage_getMemoList');
      }
    }
  }

  //메모 수정하기 api
  void putMemo() async {
    Map data = {
      "book_no": widget.book['book_no'],
      "memo_content": _memoController.text,
      // "memo_quote": "" //인용
    };
    final response = await memoService.putMemo(widget.book['id'], data);
    if (response?.statusCode == 200) {
      //기존에 이미지 있는 경우
      if (widget.book['image_url'] != null) {
        //이미지가 선택되어 있으면
        if (ref.watch(memoImageNameProvider) != null) {
          //기존 이미지와 수정된 이미지가 다른 경우
          if (ref.watch(memoImageNameProvider) != widget.book['image_url']) {
            postMemoImage(widget.book['id']);
            print('이미지를 변경');
          } else {
            //텍스트만 수정함
            print('텍스트만 수정함');
            context.pop();
            context.pop('MemoPage_getMemoList');
          }
        } else {
          //기존 이미지를 삭제한 경우
          deleteMemoImage(widget.book['id']);
          print('이미지 삭제하고 추가해라');
        }
        //기존에 이미지 없는 경우
      } else {
        //이미지를 추가함
        if (ref.watch(memoImageNameProvider) != null) {
          print('이미지를 추가함');
          postMemoImage(widget.book['id']);
        } else {
          //텍스트만 수정함
          print('텍스트만 수정함');
          context.pop();
          context.pop('MemoPage_getMemoList');
        }
      }
    }
  }

  //메모 이미지 업로드 api
  void postMemoImage(int id) async {
    final response = await memoService.postMemoImage(
        id, ref.watch(memoImageFileProvider)!.path);
    if (response?.statusCode == 201) {
      context.pop();
      context.pop('MemoPage_getMemoList');
    }
  }

  //메모 이미지 삭제 api
  void deleteMemoImage(int id) async {
    final response = await memoService.deleteMemoImage(id);
    if (response?.statusCode == 201) {
      context.pop();
      context.pop('MemoPage_getMemoList');
    }
  }

  //갤러리 열기
  Future<void> _pickImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    ref.read(memoImageFileProvider.notifier).state = image;
    ref.read(memoImageNameProvider.notifier).state = image?.name;
  }

  //카메라
  Future<void> _takePhoto() async {
    final XFile? photo =
        await _imagePicker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      ref.read(memoImageFileProvider.notifier).state = photo;
      ref.read(memoImageNameProvider.notifier).state = photo.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final okButtonBool = ref.watch(okButtonProvider);

    return Scaffold(
      appBar: Widgets.appBar(context,
          title: (widget.book['id'] == null) ? '메모 작성하기' : '메모 수정하기',
          actions: [
            GestureDetector(
              onTap: () {
                if (okButtonBool) {
                  if (widget.book['id'] == null) {
                    postMemo();
                  } else {
                    putMemo();
                  }
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
          print(widget.book);
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
                  (widget.book['book_image_url'] == null)
                      ? Container(
                          width: 48.w,
                          height: 64.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.grey_F2),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            width: 48.w,
                            height: 64.h,
                            fit: BoxFit.cover,
                            widget.book['book_image_url'],
                          ),
                        ),
                  Container(
                    width: 252.w,
                    margin: EdgeInsets.only(left: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.book['book_title'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          widget.book['book_author'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12.sp, color: AppColors.grey_8D),
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
                    visible: ref.watch(memoImageNameProvider) != null,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 20.h),
                            child: _image()),
                        GestureDetector(
                          onTap: () {
                            ref.read(memoImageFileProvider.notifier).state =
                                null;
                            ref.read(memoImageNameProvider.notifier).state =
                                null;
                            ref.read(memoImageUpdateProvider.notifier).state =
                                true;
                          },
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
                (ref.watch(memoImageNameProvider.notifier).state == null)
                    ? GestureDetector(
                        onTap: () => _takePhoto(),
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
                (ref.watch(memoImageNameProvider.notifier).state == null)
                    ? GestureDetector(
                        onTap: () => _pickImage(),
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

  Widget _image() {
    if (widget.book['image_url'] != null &&
        ref.watch(memoImageUpdateProvider) != true) {
      return Image.network(
          width: 320.w,
          height: 165.h,
          fit: BoxFit.fitWidth,
          Constant.IMAGE_URL + widget.book['image_url']);
    } else {
      return Image.file(
          width: 320.w,
          height: 165.h,
          //TODO - 나중에 설정
          fit: BoxFit.fitWidth,
          File(ref.watch(memoImageFileProvider)?.path ?? ''));
    }
  }
}
