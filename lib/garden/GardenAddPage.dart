import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/service/GardenService.dart';
import '../utils/Constant.dart';
import '../utils/Widgets.dart';

//가든 추가하기 버튼 ...
final gardenAddButtonProvider = StateProvider<bool>((ref) => false);
//가든 색상 선택 인덱스 ...
final gardenColorSelectIndexProvider = StateProvider<int>((ref) => 0);

class GardenAddPage extends ConsumerStatefulWidget {
  _GardenAddPageState createState() => _GardenAddPageState();
}

class _GardenAddPageState extends ConsumerState<GardenAddPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(gardenAddButtonProvider.notifier).state = false;
      ref.read(gardenColorSelectIndexProvider.notifier).state = 0;
    });
  }

  //가든 추가 api
  void postGarden() async {
    final data = {
      "garden_title": _titleController.text,
      "garden_info": _infoController.text,
      "garden_color":
          Constant.GARDEN_COLOR_LIST[ref.watch(gardenColorSelectIndexProvider)]
    };

    final response = await gardenService.postGarden(data);
    if (response?.statusCode == 201) {
      context.pushNamed('garden-add-done');
    }
  }

  //추가하기 버튼 유효성
  void _gardenAddValid() {
    if (_titleController.text.isNotEmpty && _infoController.text.isNotEmpty) {
      ref.read(gardenAddButtonProvider.notifier).state = true;
    } else {
      ref.read(gardenAddButtonProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context, title: '새로운 가든 추가하기'),
      body: Container(
        margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widgets.textfield(ref, _titleController, '가든 이름',
                '영어, 한글 최대 10글자까지 쓸 수 있어요', null, StateProvider((ref) => null),
                validateFunction: _gardenAddValid),
            Widgets.textfield(ref, _infoController, '가든 소개', '소개글을 입력해주세요',
                null, StateProvider((ref) => null),
                validateFunction: _gardenAddValid),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 16.h, top: 12.h),
                    child: const Text('대표 색상')),
                SizedBox(
                  height: 92.h,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                .read(gardenColorSelectIndexProvider.notifier)
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
                                            gardenColorSelectIndexProvider) ==
                                        index)
                                    ? Border.all(
                                        color: Constant
                                            .GARDEN_COLOR_SET_LIST[index],
                                        width: 2.w,
                                      )
                                    : null),
                            child: Container(
                                decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Constant.GARDEN_COLOR_SET_LIST[index],
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
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
          child: Widgets.button(
              '추가하기', ref.watch(gardenAddButtonProvider), () => postGarden())),
    );
  }
}

class GardenAddDonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      context.pop();
      context.pushNamed('bottom-navi');
    });
    return Scaffold(
      body: Center(),
    );
  }
}
