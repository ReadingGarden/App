import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../core/api/AuthAPI.dart';
import '../core/api/GardenAPI.dart';
import '../core/service/GardenService.dart';
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Functions.dart';
import '../utils/Widgets.dart';

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

    final gardenAPI = GardenAPI(ref);

    Future.microtask(() {
      ref.read(gardenEditButtonProvider.notifier).state = true;
      ref.read(gardenEditColorSelectIndexProvider.notifier).state = Constant
          .GARDEN_COLOR_LIST
          .indexOf(gardenAPI.gardenMain()['garden_color']);
      ref.read(gardenEditSelectIndexProvider.notifier).state = 0;
      _titleController.text = gardenAPI.gardenMain()['garden_title'];
      _infoController.text = gardenAPI.gardenMain()['garden_info'];
    });
  }

  //가든 삭제 api
  void deleteGarden() async {
    final gardenAPI = GardenAPI(ref);

    final response =
        await gardenService.deleteGarden(gardenAPI.gardenMain()['garden_no']);
    if (response?.statusCode == 200) {
      context.pop();
      context.pushNamed('bottom-navi');
    } else if (response?.statusCode == 403) {
      fToast.showToast(child: Widgets.toast('😢 가든이 하나뿐이라 삭제할 수 없어요'));
    }
  }

  //가든 이전 api
  void moveToGarden(int to_garden_no) async {
    final gardenAPI = GardenAPI(ref);

    final response = await gardenService.moveToGarden(
        gardenAPI.gardenMain()['garden_no'], to_garden_no);
    if (response?.statusCode == 200) {
      context.pop();
      fToast.showToast(child: Widgets.toast('👌 남아있는 책을 모두 옮겼어요!'));
      gardenAPI.getGardenLsit();
    } else if (response?.statusCode == 403) {
      fToast.showToast(child: Widgets.toast('😢 꽉 찼어요! 다른 가든을 선택해주세요'));
    }
  }

  //가든 수정 api
  void putGarden() async {
    final gardenAPI = GardenAPI(ref);

    final data = {
      "garden_title": _titleController.text,
      "garden_info": _infoController.text,
      "garden_color": Constant
          .GARDEN_COLOR_LIST[ref.watch(gardenEditColorSelectIndexProvider)]
    };
    final response = await gardenService.putGarden(
        gardenAPI.gardenMain()['garden_no'], data);
    if (response?.statusCode == 200) {
      context.pop();
      context.pushNamed('bottom-navi');
    } else if (response?.statusCode == 401) {}
  }

  //가든 탈퇴 api
  void byeGarden() async {
    final gardenAPI = GardenAPI(ref);

    final response =
        await gardenService.byeGarden(gardenAPI.gardenMain()['garden_no']);
    if (response?.statusCode == 200) {
      context.pop();
      context.pushNamed('bottom-navi');
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

  //가든 리더 확인
  bool _gardenLeaderBool() {
    final authAPI = AuthAPI(ref);
    final gardenAPI = GardenAPI(ref);

    bool leaderBool = false;

    for (var member in gardenAPI.gardenMain()['garden_members']) {
      if (member['user_no'] == authAPI.user()['user_no']) {
        leaderBool = member['garden_leader'];
      }
    }
    return leaderBool;
  }

  @override
  Widget build(BuildContext context) {
    final gardenAPI = GardenAPI(ref);

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
              gardenAPI.gardenMain()['garden_members'].length <= 1
                  ? GestureDetector(
                      onTap: () =>
                          (gardenAPI.gardenMain()['book_list'].length > 0)
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
                  ));
        },
        cancelTitle: '건너뛰기',
        contentWidget: Text.rich(
            TextSpan(style: TextStyle(fontSize: 14.sp), children: const [
          TextSpan(text: '독서기록과 메모를 유지하고 싶다면'),
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
  GardenEditBottomSheet({super.key, required this.function});

  final Function(int) function;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gardenAPI = GardenAPI(ref);

    return Container(
      margin: EdgeInsets.only(top: 30.h, left: 24.w, right: 24.w),
      height: (68.h + 10.h) * gardenAPI.gardenList().length + 90.h,
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
              gardenAPI.gardenList().length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    if (gardenAPI.gardenMain()['garden_no'] !=
                        gardenAPI.gardenList()[index]['garden_no']) {
                      ref.read(gardenEditSelectIndexProvider.notifier).state =
                          index;

                      function(gardenAPI.gardenList()[index]['garden_no']);
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
                                color: (gardenAPI.gardenMain()['garden_no'] ==
                                        gardenAPI.gardenList()[index]
                                            ['garden_no'])
                                    ? Colors.transparent
                                    : (index ==
                                            ref.watch(
                                                gardenEditSelectIndexProvider))
                                        ? AppColors.black_4A
                                        : AppColors.grey_F2),
                            color: (gardenAPI.gardenMain()['garden_no'] ==
                                    gardenAPI.gardenList()[index]['garden_no'])
                                ? AppColors.grey_F2
                                : Colors.white),
                        child: SizedBox(
                          height: 44.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                gardenAPI.gardenList()[index]['garden_title'],
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color:
                                        (gardenAPI.gardenMain()['garden_no'] ==
                                                gardenAPI.gardenList()[index]
                                                    ['garden_no'])
                                            ? AppColors.grey_8D
                                            : Colors.black),
                              ),
                              Text(
                                '심은 꽃 ${gardenAPI.gardenList()[index]['book_count']}/30',
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
                          'assets/images/garden-color.svg',
                          width: 20.w,
                          color: Functions.gardenColor(
                              gardenAPI.gardenList()[index]['garden_color']),
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
