import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../core/provider/ResponseProvider.dart';
import '../core/service/GardenService.dart';
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Widgets.dart';
import 'GardenPage.dart';

//가든 수정하기 버튼 상태를 관리하는 ...
final gardenEditButtonProvider = StateProvider<bool>((ref) => true);
//가든 수정 색상 선택 인덱스 상태를 관리하는 ...
final gardenEditColorSelectIndexProvider = StateProvider<int>((ref) => 0);

class GardenEditPage extends ConsumerStatefulWidget {
  _GardenEditPageState createState() => _GardenEditPageState();
}

class _GardenEditPageState extends ConsumerState<GardenEditPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    Future.microtask(() {
      ref.read(gardenEditButtonProvider.notifier).state = true;
      ref.read(gardenEditColorSelectIndexProvider.notifier).state = 0;
      _titleController.text = ref.watch(gardenMainProvider)['garden_title'];
      _infoController.text = ref.watch(gardenMainProvider)['garden_info'];
    });
  }

  //가든 삭제 api
  void deleteGarden() async {
    final response = await gardenService
        .deleteGarden(ref.watch(gardenMainProvider)['garden_no']);
    if (response?.statusCode == 200) {
      context.pop();
      context.pushNamed('bottom-navi');
    } else if (response?.statusCode == 403) {
      fToast.showToast(child: Widgets.toast('😢 가든이 하나뿐이라 삭제할 수 없어요'));
    }
  }

  //가든 수정 api
  void putGarden() async {
    final data = {
      "garden_title": _titleController.text,
      "garden_info": _infoController.text,
      "garden_color": Constant
          .GARDEN_COLOR_LIST[ref.watch(gardenEditColorSelectIndexProvider)]
    };
    final response = await gardenService.putGarden(
        ref.watch(gardenMainProvider)['garden_no'], data);
    if (response?.statusCode == 200) {
      context.pop();
      context.pushNamed('bottom-navi');
    } else if (response?.statusCode == 401) {}
  }

  //가든 나가기 api
  void byeGarden() async {
    final response = await gardenService
        .byeGarden(ref.watch(gardenMainProvider)['garden_no']);
    if (response?.statusCode == 200) {
    } else if (response?.statusCode == 401) {}
  }

  //추가하기 버튼 유효성
  void _gardenEditValid() {
    if (_titleController.text.isNotEmpty && _infoController.text.isNotEmpty) {
      ref.read(gardenEditButtonProvider.notifier).state = true;
    } else {
      ref.read(gardenEditButtonProvider.notifier).state = false;
    }
  }

  bool _gardenLeaderBool() {
    final user = ref.watch(responseProvider.userMapProvider);
    final garden = ref.watch(gardenMainProvider);

    bool leaderBool = false;
    for (var member in garden['garden_members']) {
      if (member['user_no'] == user?['user_no']) {
        leaderBool = member['garden_leader'];
      }
    }
    return leaderBool;
  }

  @override
  Widget build(BuildContext context) {
    final garden = ref.watch(gardenMainProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '가든 수정하기'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          margin: EdgeInsets.only(top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 24.w,
                  right: 24.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: _gardenLeaderBool(),
                      child: Column(
                        children: [
                          Widgets.textfield(
                              ref,
                              _titleController,
                              '가든 이름',
                              '영어, 한글 최대 10글자까지 쓸 수 있어요',
                              null,
                              StateProvider((ref) => null),
                              validateFunction: _gardenEditValid),
                          Widgets.textfield(ref, _infoController, '가든 소개',
                              '소개글을 입력해주세요', null, StateProvider((ref) => null),
                              validateFunction: _gardenEditValid),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                bottom: 16.h,
                                top: (_gardenLeaderBool()) ? 12.h : 4.h),
                            child: const Text('대표 색상')),
                        SizedBox(
                          height: 92.h,
                          child: GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 26.w,
                              mainAxisSpacing: 18.w,
                              crossAxisCount: 6,
                            ),
                            shrinkWrap: true,
                            children: List.generate(
                              Constant.GARDEN_COLOR_LIST.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(gardenEditColorSelectIndexProvider
                                            .notifier)
                                        .state = index;
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    width: 38.r,
                                    height: 38.r,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                        border: (ref.watch(
                                                    gardenEditColorSelectIndexProvider) ==
                                                index)
                                            ? Border.all(
                                                color: Constant
                                                        .GARDEN_COLOR_SET_LIST[
                                                    index],
                                                width: 2.w,
                                              )
                                            : null),
                                    child: Container(
                                        decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Constant.GARDEN_COLOR_SET_LIST[index],
                                    )),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.h, bottom: 20.h),
                height: 1.h,
                color: AppColors.grey_F2,
              ),
              garden['garden_members'].length <= 1
                  ? GestureDetector(
                      onTap: () => (garden['book_list'].length > 0)
                          ? _gardenDeleteBottomSheet()
                          : _gardenRealDeleteBottomSheet(),
                      child: Container(
                          margin: EdgeInsets.only(left: 24.w),
                          height: 46.h,
                          color: Colors.transparent,
                          child: const Text(
                            '가든 삭제하기',
                            style: TextStyle(color: AppColors.errorRedColor),
                          )),
                    )
                  : GestureDetector(
                      onTap: () => _gardenByeBottomSheet(),
                      child: Container(
                          margin: EdgeInsets.only(left: 24.w),
                          height: 46.h,
                          color: Colors.transparent,
                          child: const Text(
                            '가든 나가기',
                            style: TextStyle(color: AppColors.errorRedColor),
                          )),
                    )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
          child: Widgets.button('수정하기', ref.watch(gardenEditButtonProvider),
              () => _gardenEditBottomSheet())),
    );
  }

  //가든 수정 바텀시트
  Future _gardenEditBottomSheet() {
    return Widgets.baseBottomSheet(context, '수정한 내용을 저장할까요?',
        '이전 화면으로 돌아가기 전 수정 내역을 저장할지 저희에게 알려주세요.', '저장하고 나가기', () => putGarden(),
        cancelTitle: '그냥 나가기', cancelBtnFunction: () {
      context.pop();
      context.pushNamed('bottom-navi');
    });
  }

  //가든 나가기 바텀시트 (공유)
  Future _gardenByeBottomSheet() {
    return Widgets.deleteBottomSheet(
        context,
        '가든에서 나가시겠어요?',
        Text.rich(TextSpan(style: TextStyle(fontSize: 16.sp), children: const [
          TextSpan(text: '가든에서 나가면 '),
          TextSpan(
              text: '내가 기록한 모든 책의 기록',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '이 삭제되며, 다른 참여자들도. 나의 기록을 볼 수 없습니다.'),
        ])),
        '나가기',
        () => byeGarden());
  }

  //가든 이전하기 바텀시트 (개인)
  Future _gardenDeleteBottomSheet() {
    return Widgets.baseBottomSheet(
        context, '가든에 남아있는 책이 있어요!', '', '전체 이전하기', () => byeGarden(),
        cancelTitle: '건너뛰기',
        contentWidget: Text.rich(
            TextSpan(style: TextStyle(fontSize: 16.sp), children: const [
          TextSpan(text: '독서기록과 메모를 유지하고 싶다면'),
          TextSpan(
              text: '전체 이전하기', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '를 해주세요.'),
        ])), cancelBtnFunction: () {
      context.pop();
      _gardenRealDeleteBottomSheet();
    });
  }

  Future _gardenRealDeleteBottomSheet() {
    return Widgets.deleteBottomSheet(
        context,
        '가든을 삭제하시겠어요?',
        Text.rich(TextSpan(style: TextStyle(fontSize: 16.sp), children: const [
          TextSpan(text: '가든을 삭제하면 저장된 '),
          TextSpan(
              text: '모든 독서 기록', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '이 삭제되며, 다시 되돌릴 수 없습니다.'),
        ])),
        '삭제하기',
        () => deleteGarden());
  }
}
