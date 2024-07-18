import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/service/MemoService.dart';
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Functions.dart';

final memoListProvider = StateProvider<List>((ref) => []);
final memoSelectIndexListProvider = StateProvider<List>((ref) => []);

class MemoPage extends ConsumerStatefulWidget {
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends ConsumerState<MemoPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(memoListProvider.notifier).state = [];
      ref.read(memoSelectIndexListProvider.notifier).state = [];
    });
    getMemoLsit();
  }

  //메모 리스트 조회 api
  void getMemoLsit() async {
    final response = await memoService.getMemoList();
    if (response?.statusCode == 200) {
      ref.read(memoListProvider.notifier).state = response?.data['data'];
      for (var i in ref.watch(memoListProvider)) {
        ref
            .read(memoSelectIndexListProvider.notifier)
            .state
            .add(i['memo_like']);
      }
    } else if (response?.statusCode == 401) {
      print('토큰에러');
    }
  }

  //메모 즐겨찾기 api
  void putMemoLike(int index, int id) async {
    final response = await memoService.putMemoLike(id);
    if (response?.statusCode == 200) {
      ref.read(memoSelectIndexListProvider.notifier).update((state) {
        List<bool> newState = List.from(state);
        newState[index] = !newState[index];
        return newState;
      });
    } else if (response?.statusCode == 401) {
      print('토큰에러');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.red,
          toolbarHeight: 60.h,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          centerTitle: false,
          title: Text(
            '메모',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                final result = await context.pushNamed('memo-book');
                if (result != null) {
                  getMemoLsit();
                }
              },
              child: Container(
                margin: EdgeInsets.only(right: 14.w),
                color: Colors.transparent,
                child: SvgPicture.asset(
                  'assets/images/angle-left-write.svg',
                  width: 32.r,
                  height: 32.r,
                ),
              ),
            )
          ],
        ),
        body: (ref.watch(memoListProvider).isNotEmpty)
            ? _memoList()
            : _emptyMemoList());
  }

  Widget _memoList() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: List.generate(
        ref.read(memoListProvider).length,
        (index) {
          return GestureDetector(
            onTap: () async {
              final result = await context.pushNamed('memo-detail',
                  extra: ref.read(memoListProvider)[index]);
              if (result != null) {
                getMemoLsit();
              }
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
              width: 312.w,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey_F2),
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.transparent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44.r,
                        height: 44.r,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.green),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12.w),
                        child: Column(
                          children: [
                            Text(
                              ref.watch(memoListProvider)[index]['book_title'],
                            ),
                            Text(
                              ref.watch(memoListProvider)[index]['book_author'],
                              style: TextStyle(
                                  fontSize: 12.sp, color: AppColors.grey_8D),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Visibility(
                      visible: (ref.watch(memoListProvider)[index]
                              ['image_url'] !=
                          null),
                      child: Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: Image.network(
                            width: 320.w,
                            height: 140.h,
                            fit: BoxFit.fitWidth,
                            '${Constant.IMAGE_URL}${ref.watch(memoListProvider)[index]['image_url']}'),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 10.h),
                      child: Text(
                        ref.watch(memoListProvider)[index]['memo_content'],
                        maxLines: 5,
                        style: TextStyle(
                            fontSize: 12.sp, overflow: TextOverflow.ellipsis),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Functions.formatDate(
                                ref.watch(memoListProvider)[index]
                                    ['memo_created_at']),
                            style: TextStyle(
                                fontSize: 12.sp, color: AppColors.grey_8D),
                          ),
                          GestureDetector(
                            onTap: () => putMemoLike(index,
                                ref.watch(memoListProvider)[index]['id']),
                            child: SvgPicture.asset(
                              ref.watch(memoSelectIndexListProvider)[index]
                                  ? 'assets/images/star.svg'
                                  : 'assets/images/star-dis.svg',
                              width: 20.r,
                              height: 20.r,
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _emptyMemoList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20.h),
            width: 120.w,
            height: 130.h,
            color: Colors.red,
          ),
          SizedBox(
            height: 44.h,
            child: const Text(
              '지금 읽고 있는 책이 있나요?\n책을 추가하고 가든을 가꿔보세요',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.grey_8D),
            ),
          ),
        ],
      ),
    );
  }
}
