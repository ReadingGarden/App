import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

class MemoBookPage extends ConsumerStatefulWidget {
  @override
  _MemoBookPageState createState() => _MemoBookPageState();
}

class _MemoBookPageState extends ConsumerState<MemoBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context, title: '메모 작성하기', actions: [
        Container(
          margin: EdgeInsets.only(right: 24.w),
          height: 24.h,
          child: Text(
            '완료',
            style: TextStyle(fontSize: 16.sp, color: AppColors.primaryColor),
          ),
        )
      ]),
    );
  }
}
