import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:book_flutter/core/media/image_picker_helper.dart';
import 'package:book_flutter/shared/widgets/app_widgets.dart';
import 'package:book_flutter/features/memo/domain/entities/memo_write_input_entity.dart';
import 'package:book_flutter/features/memo/presentation/providers/memo_write_provider.dart'
    as memo_write_feature;
import 'package:book_flutter/shared/constants/app_constant.dart';
import 'package:book_flutter/shared/theme/app_assets.dart';
import 'package:book_flutter/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:book_flutter/gen/assets.gen.dart';

class MemoWritePage extends ConsumerStatefulWidget {
  const MemoWritePage({super.key, required this.book});

  final MemoWriteInputEntity book;

  @override
  ConsumerState<MemoWritePage> createState() => _MemoBookPageState();
}

class _MemoBookPageState extends ConsumerState<MemoWritePage> {
  final TextEditingController _memoController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _memoController.text = widget.book.memoContent;
    Future.microtask(() {
      memo_write_feature.initializeMemoWrite(ref, widget.book);
    });
  }

  @override
  void dispose() {
    _memoController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  //메모 작성하기 api
  void postMemo({bool? isBookDetail}) async {
    final saved = await memo_write_feature.saveMemo(
      ref,
      widget.book,
      _memoController.text,
    );
    if (!saved || !mounted) {
      return;
    }
    if (widget.book.gardenNo == null) {
      context.pop('MemoPage_getMemoList');
    } else {
      context.pop('BookDetailPage_getBookRead');
    }
  }

  //메모 수정하기 api
  void putMemo() async {
    final saved = await memo_write_feature.saveMemo(
      ref,
      widget.book,
      _memoController.text,
    );
    if (!saved || !mounted) {
      return;
    }
    if (widget.book.gardenNo == null) {
      context.pop('MemoPage_getMemoList');
    } else {
      context.pop('BookDetailPage_getBookRead');
    }
  }

  //갤러리 열기
  Future<void> _pickImage() async {
    final XFile? image = await AppImagePicker.pickFromGallery();
    memo_write_feature.setMemoImage(ref, image);
  }

  //카메라
  Future<void> _takePhoto() async {
    final XFile? photo = await AppImagePicker.takePhoto();

    if (photo != null) {
      memo_write_feature.setMemoImage(ref, photo);
    }
  }

  @override
  Widget build(BuildContext context) {
    final okButtonBool = ref.watch(memo_write_feature.okButtonProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Widgets.baseBottomSheet(context, '메모가 저장되지 않았어요!',
            '작성하던 메모를 삭제하고 이전 페이지로 돌아가시겠어요?', '삭제하고 나가기', () {
          context.pop();
          context.pop();
          context.pop();
        });
      },
      child: Scaffold(
        appBar: Widgets.appBar(context,
            title: (!widget.book.isEdit) ? '메모 작성하기' : '메모 수정하기',
            actions: [
              GestureDetector(
                onTap: () {
                  if (okButtonBool) {
                    if (!widget.book.isEdit) {
                      postMemo();
                    } else {
                      putMemo();
                    }
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(right: 24.w),
                  // height: 24.h,
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
                    (widget.book.bookImageUrl == null)
                        ? Container(
                            width: 48.w,
                            height: 64.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: AppColors.grey_F2),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: CachedNetworkImage(
                              imageUrl: widget.book.bookImageUrl!,
                              width: 48.w,
                              height: 64.h,
                              fit: BoxFit.cover,
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
                            widget.book.bookTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          Text(
                            widget.book.bookAuthor,
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
                      visible:
                          ref.watch(memo_write_feature.memoImageNameProvider) !=
                              null,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 20.h),
                              child: _image()),
                          GestureDetector(
                            onTap: () {
                              memo_write_feature.clearMemoImage(ref);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin:
                                  EdgeInsets.only(right: 10.w, bottom: 10.h),
                              width: 30.r,
                              height: 30.r,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.r)),
                              child: AppAssets.iconClose.svg(
                                colorFilter: const ColorFilter.mode(
                                  AppColors.primaryColor,
                                  BlendMode.srcIn,
                                ),
                                width: 20.r,
                                height: 20.r,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: TextField(
                            textInputAction: TextInputAction.newline,
                            controller: _memoController,
                            focusNode: _focusNode,
                            maxLines: null,
                            style: TextStyle(fontSize: 14.sp, height: 1.7.h),
                            onChanged: (value) {
                              memo_write_feature.updateMemoTextState(
                                  ref, value);
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    '책에 대해 적어보세요.\n생각, 느낌, 독서 환경 등 뭐든 상관 없어요!',
                                hintMaxLines: 3,
                                hintStyle:
                                    TextStyle(color: AppColors.grey_8D))))
                  ],
                ),
              )
            ]),
          ),
        ),
        bottomSheet: Builder(builder: (sheetContext) {
          final keyboardVisible = MediaQuery.of(sheetContext).viewInsets.bottom > 0;
          final bottomSafe = keyboardVisible
              ? 0.0
              : MediaQuery.of(context).viewPadding.bottom;
          return Container(
          padding:
              EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h, bottom: 4.h + bottomSafe),
          height: 38.h + bottomSafe,
          color: AppColors.grey_F2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  (ref.watch(memo_write_feature.memoImageNameProvider) == null)
                      ? GestureDetector(
                          onTap: () => _takePhoto(),
                          child: AppAssets.iconCamera.svg(
                            colorFilter: const ColorFilter.mode(
                              AppColors.black_59,
                              BlendMode.srcIn,
                            ),
                            width: 24.r,
                            height: 24.r,
                          ),
                        )
                      : AppAssets.iconCamera.svg(
                          colorFilter: const ColorFilter.mode(
                            AppColors.grey_CA,
                            BlendMode.srcIn,
                          ),
                          width: 24.r,
                          height: 24.r,
                        ),
                  (ref.watch(memo_write_feature.memoImageNameProvider) == null)
                      ? GestureDetector(
                          onTap: () => _pickImage(),
                          child: Container(
                            margin: EdgeInsets.only(left: 10.w),
                            color: Colors.transparent,
                            child: Assets.icons.iconAlbum.svg(
                              colorFilter: const ColorFilter.mode(
                                AppColors.black_59,
                                BlendMode.srcIn,
                              ),
                              width: 24.r,
                              height: 24.r,
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(left: 10.w),
                          color: Colors.transparent,
                          child: Assets.icons.iconAlbum.svg(
                            colorFilter: const ColorFilter.mode(
                              AppColors.grey_CA,
                              BlendMode.srcIn,
                            ),
                            width: 24.r,
                            height: 24.r,
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
                child: ((!FocusScope.of(context).hasFocus)
                        ? AppAssets.iconKeyboardUp
                        : AppAssets.iconKeyboardDown)
                    .svg(
                  colorFilter: const ColorFilter.mode(
                    AppColors.black_59,
                    BlendMode.srcIn,
                  ),
                  width: 24.r,
                  height: 24.r,
                ),
              ),
            ],
          ),
        );
        }),
      ),
    );
  }

  Widget _image() {
    if (widget.book.imageUrl != null &&
        ref.watch(memo_write_feature.memoImageUpdateProvider) != true) {
      return CachedNetworkImage(
          imageUrl: Constant.IMAGE_URL + widget.book.imageUrl!,
          width: 320.w);
    } else {
      final file = ref.watch(memo_write_feature.memoImageFileProvider);
      if (file == null) return const SizedBox.shrink();
      return Image.file(File(file.path), width: 320.w);
    }
  }
}
