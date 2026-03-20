import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../core/api/AuthAPI.dart';
import '../core/service/GardenService.dart';
import '../features/garden/presentation/providers/garden_provider.dart'
    as garden_feature;
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Functions.dart';
import '../core/ui/app_widgets.dart';

//가든 선택 인덱스 ...
final gardenEditSelectIndexProvider = StateProvider<int>((ref) => 0);
//가든 수정하기 버튼 ...
final gardenEditButtonProvider = StateProvider<bool>((ref) => true);
//가든 수정 색상 선택 인덱스 ...
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
      final gardenMain = ref.read(garden_feature.gardenMainProvider);
      ref.read(gardenEditButtonProvider.notifier).state = true;
      ref.read(gardenEditColorSelectIndexProvider.notifier).state = Constant
          .GARDEN_COLOR_LIST
          .indexOf(gardenMain.gardenColor);
      ref.read(gardenEditSelectIndexProvider.notifier).state = 0;
      _titleController.text = gardenMain.gardenTitle;
      _infoController.text = gardenMain.gardenInfo;
    });
  }

  //가든 삭제 api
  void deleteGarden() async {
    final gardenMain = ref.read(garden_feature.gardenMainProvider);

    final response = await gardenService.deleteGarden(gardenMain.gardenNo);
    if (response?.statusCode == 200) {
      context.pop();
      context.replaceNamed('bottom-navi');
    } else if (response?.statusCode == 403) {
      fToast.showToast(child: Widgets.toast('가든이 하나뿐이라 삭제할 수 없어요'));
    }
  }

  //가든 이전 api
  void moveToGarden(int to_garden_no) async {
    final gardenMain = ref.read(garden_feature.gardenMainProvider);

    final response = await gardenService.moveToGarden(
        gardenMain.gardenNo, to_garden_no);
    if (response?.statusCode == 200) {
      context.pop();
      fToast.showToast(child: Widgets.toast('남아있는 책을 모두 옮겼어요!'));
      garden_feature.fetchGardenList(ref);
    } else if (response?.statusCode == 403) {
      fToast.showToast(child: Widgets.toast('꽉 찼어요! 다른 가든을 선택해주세요'));
    }
  }

  //가든 수정 api
  void putGarden() async {
    final gardenMain = ref.read(garden_feature.gardenMainProvider);

    final data = {
      "garden_title": _titleController.text,
      "garden_info": _infoController.text,
      "garden_color": Constant
          .GARDEN_COLOR_LIST[ref.watch(gardenEditColorSelectIndexProvider)]
    };
    final response = await gardenService.putGarden(gardenMain.gardenNo, data);
    if (response?.statusCode == 200) {
      await garden_feature.fetchGardenDetail(ref, gardenMain.gardenNo);
      context.replaceNamed('bottom-navi');
    }
  }

  //가든 탈퇴 api
  void byeGarden() async {
    final gardenMain = ref.read(garden_feature.gardenMainProvider);

    final response = await gardenService.byeGarden(gardenMain.gardenNo);
    if (response?.statusCode == 200) {
      context.pop();
      context.replaceNamed('bottom-navi');
    }
  }

  //추가하기 버튼 유효성
  void _gardenEditValid() {
    if (_titleController.text.isNotEmpty && _infoController.text.isNotEmpty) {
      ref.read(gardenEditButtonProvider.notifier).state = true;
    } else {
      ref.read(gardenEditButtonProvider.notifier).state = false;
    }
  }

  //가든 리더 확인
  bool _gardenLeaderBool() {
    final authAPI = AuthAPI(ref);
    final gardenMain = ref.read(garden_feature.gardenMainProvider);

    bool leaderBool = false;

    for (final member in gardenMain.gardenMembers) {
      if (member['user_no'] == authAPI.user()['user_no']) {
        leaderBool = member['garden_leader'];
      }
    }
    return leaderBool;
  }

  @override
  Widget build(BuildContext context) {
    final gardenMain = ref.watch(garden_feature.gardenMainProvider);

    return WillPopScope(
      onWillPop: () async {
        _gardenEditBottomSheet();
        return true;
      },
      child: Scaffold(
        appBar: Widgets.appBar(context,
            title: '가든 수정하기', backFunction: _gardenEditBottomSheet),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
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
                                  '최대 12글자까지 쓸 수 있어요',
                                  null,
                                  StateProvider((ref) => null),
                                  validateFunction: _gardenEditValid),
                              Widgets.textfield(
                                  ref,
                                  _infoController,
                                  '가든 소개',
                                  '소개글을 입력해주세요',
                                  null,
                                  StateProvider((ref) => null),
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
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: List.generate(
                                  Constant.GARDEN_COLOR_LIST.length,
                                  (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(
                                                gardenEditColorSelectIndexProvider
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
                                          color: Constant
                                              .GARDEN_COLOR_SET_LIST[index],
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
                  gardenMain.gardenMembers.length <= 1
                      ? GestureDetector(
                          onTap: () =>
                              (gardenMain.bookList.isNotEmpty)
                                  ? _gardenDeleteBottomSheet()
                                  : _gardenRealDeleteBottomSheet(),
                          child: Container(
                              margin: EdgeInsets.only(left: 24.w),
                              height: 46.h,
                              color: Colors.transparent,
                              child: const Text(
                                '가든 삭제하기',
                                style:
                                    TextStyle(color: AppColors.errorRedColor),
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
                                style:
                                    TextStyle(color: AppColors.errorRedColor),
                              )),
                        )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
            margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
            child: Widgets.button('수정하기', ref.watch(gardenEditButtonProvider),
                () => putGarden())),
      ),
    );
  }

  //가든 수정 바텀시트
  Future _gardenEditBottomSheet() {
    return Widgets.baseBottomSheet(
        context,
        '수정한 내용을 저장할까요?',
        '이전 화면으로 돌아가기 전 수정 내역을 저장할지 저희에게 알려주세요.',
        '저장하고 나가기',
        () {
          context.pop();
          putGarden();
        },
        cancelTitle: '그냥 나가기',
        cancelBtnFunction: () {
          context.pop();
          context.pop();
        });
  }

  //가든 나가기 바텀시트 (공유)
  Future _gardenByeBottomSheet() {
    return Widgets.deleteBottomSheet(
        context,
        '가든에서 나가시겠어요?',
        Text.rich(TextSpan(style: TextStyle(fontSize: 14.sp), children: const [
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
    final gardenMain = ref.read(garden_feature.gardenMainProvider);

    return Widgets.baseBottomSheet(
        context,
        '가든에 남아있는 책이 있어요!',
        '',
        '전체 이전하기',
        () {
          context.pop();
          showModalBottomSheet(
              backgroundColor: Colors.white,
              isScrollControlled: true,
              context: context,
              builder: (context) => GardenEditBottomSheet(
                    function: (int to_garden_no) {
                      moveToGarden(to_garden_no);
                    },
                    gardenNo: gardenMain.gardenNo,
                  ));
        },
        cancelTitle: '건너뛰기',
        contentWidget: Text.rich(
            TextSpan(style: TextStyle(fontSize: 14.sp), children: const [
          TextSpan(text: '독서기록과 메모를 유지하고 싶다면 '),
          TextSpan(
              text: '전체 이전하기', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '를 해주세요.'),
        ])),
        cancelBtnFunction: () {
          context.pop();
          _gardenRealDeleteBottomSheet();
        });
  }

  //가든 삭제하기 바텀시트 (개인)
  Future _gardenRealDeleteBottomSheet() {
    return Widgets.deleteBottomSheet(
        context,
        '가든을 삭제하시겠어요?',
        Text.rich(TextSpan(style: TextStyle(fontSize: 14.sp), children: const [
          TextSpan(text: '가든을 삭제하면 저장된 '),
          TextSpan(
              text: '모든 독서 기록', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '이 삭제되며, 다시 되돌릴 수 없습니다.'),
        ])),
        '삭제하기',
        () => deleteGarden());
  }
}

//가든 선택 바텀시트
class GardenEditBottomSheet extends ConsumerWidget {
  GardenEditBottomSheet(
      {super.key, required this.function, required this.gardenNo});

  final Function(int) function;
  final int gardenNo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gardens = ref.watch(garden_feature.gardenListProvider);

    return Container(
      margin: EdgeInsets.only(top: 30.h, left: 24.w, right: 24.w),
      height:
          (68.h + 10.h) * gardens.length + 24.h + 20.h + 30.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 24.h),
            child: Text(
              '어느 가든으로 이전할까요?',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(
              gardens.length,
              (index) {
                final garden = gardens[index];
                return GestureDetector(
                  onTap: () {
                    if (gardenNo != garden.gardenNo) {
                      ref.read(gardenEditSelectIndexProvider.notifier).state =
                          index;

                      function(garden.gardenNo);
                    }
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(bottom: 10.h),
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        height: 68.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                                color: (gardenNo == garden.gardenNo)
                                    ? Colors.transparent
                                    : (index ==
                                            ref.watch(
                                                gardenEditSelectIndexProvider))
                                        ? AppColors.black_59
                                        : AppColors.grey_F2),
                            color: (gardenNo == garden.gardenNo)
                                ? AppColors.grey_F2
                                : Colors.white),
                        child: SizedBox(
                          // height: 44.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                garden.gardenTitle,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: (gardenNo == garden.gardenNo)
                                        ? AppColors.grey_8D
                                        : Colors.black),
                              ),
                              Text(
                                '심은 꽃 ${garden.bookCount}/30',
                                style: TextStyle(
                                    fontSize: 12.sp, color: AppColors.grey_8D),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20.w),
                        child: SvgPicture.asset(
                          '${Constant.ASSETS_ICONS}icon_bookmark_full.svg',
                          width: 20.w,
                          height: 24.h,
                          color: Functions.gardenColor(garden.gardenColor),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
