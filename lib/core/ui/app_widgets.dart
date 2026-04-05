import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../gen/assets.gen.dart';
import '../common/functions.dart';
import 'app_colors.dart';

class Widgets {
  static appBar(BuildContext context,
      {String? title,
      List<Widget>? actions,
      Function? backFunction,
      Color? color}) {
    return AppBar(
      // 스크롤 -> 반투명 없애기
      scrolledUnderElevation: 0,
      backgroundColor: (color != null) ? color : Colors.white,
      toolbarHeight: 60.h,
      centerTitle: true,
      title: Text(
        title ?? '',
        maxLines: 1,
        style: TextStyle(fontSize: 16.sp),
      ),
      leading: GestureDetector(
        onTap: () {
          if (backFunction != null) {
            backFunction();
          } else {
            context.pop();
          }
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Assets.icons.iconAngleLeft.svg(
            width: 24.r,
            height: 24.r,
          ),
        ),
      ),

      actions: actions,
    );
  }

  static button(
    String title,
    bool isValid,
    Function function,
  ) {
    return GestureDetector(
      onTap: () => isValid ? function() : null,
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: isValid ? AppColors.black_59 : AppColors.grey_CA),
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              color: Colors.white),
        )),
      ),
    );
  }

  static redButton(
    String title,
    Function function,
  ) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.buttonRedColor),
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: AppColors.errorRedColor),
        )),
      ),
    );
  }

  static textfield(
      WidgetRef ref,
      TextEditingController controller,
      String label,
      String hintText,
      String? errorText,
      StateProvider<String?> errorProvider,
      {Function? validateFunction,
      bool? isPwd}) {
    return Container(
      padding: EdgeInsets.only(bottom: 12.h),
      // padding: (errorText == null)
      //     ? EdgeInsets.only(top: 6.h, bottom: 12.h)
      //     : EdgeInsets.only(top: 8.h, bottom: 8.h),
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
            maxLength: (label == '가든 소개')
                ? 30
                : (label == '가든 이름')
                    ? 10
                    : (label == '총 페이지')
                        ? 4
                        : (label == '닉네임')
                            ? 15
                            : null,
            maxLines: (label == '가든 소개') ? 2 : 1,
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
            textInputAction: (label == '가든 소개') ? TextInputAction.done : null,
            style: TextStyle(fontSize: 16.sp),
            obscureText: (isPwd == null) ? false : isPwd,
            decoration: InputDecoration(
              counter: (label == '가든 소개' ||
                      label == '가든 이름' ||
                      label == '총 페이지' ||
                      label == '닉네임')
                  ? Container()
                  : null,
              fillColor: AppColors.grey_FA,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 16.sp,
                color: AppColors.grey_8D,
              ),
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
    );
  }

  static toast(String msg) {
    return Container(
      width: 312.w,
      height: 40.h,
      padding: EdgeInsets.only(left: 18.w, top: 10.h, bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.black_59,
      ),
      child: Text(
        msg,
        style: TextStyle(fontSize: 14.sp, color: Colors.white),
      ),
    );
  }

  static Widget titleList(String title, Function function, {Widget? widget}) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        alignment: Alignment.centerLeft,
        width: 360.w,
        height: 46.h,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14.sp),
            ),
            widget ?? Container()
          ],
        ),
      ),
    );
  }

  static Future baseBottomSheet(BuildContext context, String title,
      String content, String btnTitle, Function btnFunction,
      {String? cancelTitle,
      Widget? contentWidget,
      Function? cancelBtnFunction}) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            height: 268.h,
            margin: EdgeInsets.only(
              top: 30.h,
              left: 24.w,
              right: 24.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 6.h, bottom: 24.h),
                  // height: 44.h,
                  child: (content != '' && contentWidget == null)
                      ? Text(
                          content,
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        )
                      : contentWidget!,
                ),
                Column(
                  children: [
                    Widgets.button(btnTitle, true, () {
                      btnFunction();
                    }),
                    GestureDetector(
                      onTap: () => (cancelBtnFunction != null)
                          ? cancelBtnFunction()
                          : context.pop(),
                      child: Container(
                        margin: EdgeInsets.only(top: 12.h),
                        height: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: AppColors.grey_F2),
                        child: Center(
                            child: Text(
                          cancelTitle ?? '취소',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: AppColors.grey_8D),
                        )),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  static Future deleteBottomSheet(BuildContext context, String title,
      Widget content, String btnTitle, Function btnFunction) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            height: 268.h,
            margin: EdgeInsets.only(top: 30.h, left: 24.w, right: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                Container(
                    margin: EdgeInsets.only(top: 6.h, bottom: 24.h),
                    child: content),
                Column(
                  children: [
                    Widgets.redButton(btnTitle, () {
                      btnFunction();
                    }),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        margin: EdgeInsets.only(top: 12.h),
                        height: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: AppColors.grey_F2),
                        child: Center(
                            child: Text(
                          '취소',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: AppColors.grey_8D),
                        )),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  static Future shareBottomSheet(
      context, String title, String garden, int gardenNo, fToast) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 30.h, left: 42.w, right: 42.w),
          height: 206.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Text(
                  title,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Container(
                            width: 64.r,
                            height: 64.r,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.grey_F2),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 8.h),
                            height: 20.h,
                            child: Text(
                              '카카오톡',
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Functions.shareBranchLink(garden, gardenNo);

                      // Clipboard.setData(ClipboardData(
                      //     text: Functions.createInviteLink(garden_no)));
                      // fToast.showToast(child: Widgets.toast('👌 초대링크를 복사했어요'));
                      context.pop();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Container(
                            width: 64.r,
                            height: 64.r,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.grey_F2),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 8.h),
                            height: 20.h,
                            child: Text(
                              '링크복사',
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Container(
                            width: 64.r,
                            height: 64.r,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.grey_F2),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 8.h),
                            height: 20.h,
                            child: Text(
                              '더보기',
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class EmptyBounce extends StatefulWidget {
  const EmptyBounce({
    super.key,
    required this.child,
    this.trigger,
    this.delay,
    this.intensity = 1.0,
  });

  final Widget child;
  final Object? trigger;
  final Duration? delay;
  final double intensity;

  @override
  State<EmptyBounce> createState() => _EmptyBounceState();
}

class _EmptyBounceState extends State<EmptyBounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    final i = widget.intensity;
    _scale = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 1.0 - 0.2 * i, end: 1.0 + 0.05 * i), weight: 60),
      TweenSequenceItem(
          tween: Tween(begin: 1.0 + 0.05 * i, end: 1.0), weight: 40),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    if (widget.delay != null) {
      Future.delayed(widget.delay!, () {
        if (mounted) _controller.forward();
      });
    } else {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(EmptyBounce oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger != oldWidget.trigger) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: ScaleTransition(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}

class Pressable extends StatefulWidget {
  const Pressable({super.key, required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _pressed = false;

  void _handleTap() {
    setState(() => _pressed = true);
    Future.delayed(const Duration(milliseconds: 120), () {
      if (!mounted) return;
      setState(() => _pressed = false);
      Future.delayed(const Duration(milliseconds: 80), () {
        if (!mounted) return;
        widget.onTap();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: widget.child,
      ),
    );
  }
}
