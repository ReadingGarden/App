import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/model/Memo.dart';
import '../core/provider/MemoListNotifier.dart';
import '../core/service/MemoService.dart';
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Functions.dart';

final memoSelectIndexListProvider = StateProvider<List>((ref) => []);

class MemoPage extends ConsumerStatefulWidget {
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends ConsumerState<MemoPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(memoListProvider.notifier).reset();
      ref.read(memoSelectIndexListProvider.notifier).state = [];
      getMemoList();
    });

    _scrollController.addListener(() {
      // 스크롤이 마지막에 도달했을 때 추가 데이터를 로드
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getMemoList();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  //메모 리스트 조회 api
  void getMemoList() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final response = await memoService.getMemoList(_currentPage);
    if (response?.statusCode == 200) {
      final List<dynamic> memoList = response?.data['data']['list'];
      final List<Memo> newMemoList = memoList
          .map((json) => Memo(
              id: json['id'],
              book_no: json['book_no'],
              book_title: json['book_title'],
              book_author: json['book_author'],
              book_image_url: json['book_image_url'],
              memo_content: json['memo_content'],
              memo_like: json['memo_like'],
              image_url: json['image_url'],
              memo_created_at: json['memo_created_at']))
          .toList();

      if (newMemoList.isNotEmpty) {
        ref.read(memoListProvider.notifier).addMemoList(newMemoList);
        setState(() {
          _currentPage++;
        });
      }

      for (var memo in newMemoList) {
        ref
            .read(memoSelectIndexListProvider.notifier)
            .state
            .add(memo.memo_like);
      }

      setState(() {
        _isLoading = false;
      });
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.h,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          leadingWidth: 0,
          leading: Container(),
          centerTitle: false,
          titleSpacing: 24.w,
          title: Text(
            '메모',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                final result = await context.pushNamed('memo-book');
                if (result != null) {
                  getMemoList();
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
            : _memoEmpty());
  }

  Widget _memoList() {
    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: List.generate(
        ref.read(memoListProvider).length,
        (index) {
          return GestureDetector(
            onTap: () async {
              final result = await context.pushNamed('memo-detail',
                  extra: ref.read(memoListProvider)[index].toJson());
              if (result != null) {
                getMemoList();
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
                      (ref.watch(memoListProvider)[index].book_image_url ==
                              null)
                          ? Container(
                              width: 44.r,
                              height: 44.r,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: AppColors.grey_F2),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.network(
                                width: 44.r,
                                height: 44.r,
                                fit: BoxFit.cover,
                                ref
                                    .watch(memoListProvider)[index]
                                    .book_image_url!,
                              ),
                            ),
                      Container(
                        width: 212.w,
                        margin: EdgeInsets.only(left: 12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ref.watch(memoListProvider)[index].book_title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              ref.watch(memoListProvider)[index].book_author,
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
                  Visibility(
                      visible: (ref.watch(memoListProvider)[index].image_url !=
                          null),
                      child: Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: Image.network(
                            width: 320.w,
                            height: 140.h,
                            fit: BoxFit.fitWidth,
                            '${Constant.IMAGE_URL}${ref.watch(memoListProvider)[index].image_url}'),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 10.h),
                      child: Text(
                        ref.watch(memoListProvider)[index].memo_content,
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
                            Functions.formatDate(ref
                                .watch(memoListProvider)[index]
                                .memo_created_at),
                            style: TextStyle(
                                fontSize: 12.sp, color: AppColors.grey_8D),
                          ),
                          GestureDetector(
                            onTap: () => putMemoLike(
                                index, ref.watch(memoListProvider)[index].id),
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

  Widget _memoEmpty() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 120.h),
      child: Column(
        children: [
          Container(
            width: 200.r,
            height: 200.r,
            color: Colors.green,
          ),
          Container(
            margin: EdgeInsets.only(top: 16.h, bottom: 6.h),
            child: Text(
              '메모를 작성해보세요',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
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
