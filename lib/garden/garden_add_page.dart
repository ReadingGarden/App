import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../core/ui/app_widgets.dart';
import '../core/constants/app_constant.dart';
import '../features/garden/domain/entities/garden_add_input_entity.dart';
import '../features/garden/presentation/providers/garden_add_provider.dart'
    as garden_add_feature;

//가든 추가하기 버튼 ...
final gardenAddButtonProvider = StateProvider<bool>((ref) => false);
//가든 색상 선택 인덱스 ...
final gardenColorSelectIndexProvider = StateProvider<int>((ref) => 0);

class GardenAddPage extends ConsumerStatefulWidget {
  const GardenAddPage({super.key});

  @override
  ConsumerState<GardenAddPage> createState() => _GardenAddPageState();
}

class _GardenAddPageState extends ConsumerState<GardenAddPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    Future.microtask(() {
      ref.read(gardenAddButtonProvider.notifier).state = false;
      ref.read(gardenColorSelectIndexProvider.notifier).state = 0;
    });
  }

  //가든 추가 api
  void postGarden() async {
    final input = GardenAddInputEntity(
      gardenTitle: _titleController.text,
      gardenInfo: _infoController.text,
      gardenColor:
          Constant.GARDEN_COLOR_LIST[ref.read(gardenColorSelectIndexProvider)],
    );

    final created =
        await garden_add_feature.createGardenAndSelectMain(ref, input);
    if (!mounted) return;
    if (created) {
      context.pushNamed('garden-add-done');
    } else {
      fToast.showToast(child: Widgets.toast('최대 5개의 가든만 만들 수 있어요'));
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
      body: GestureDetector(
        onTap: () {
          // 키보드 내리기
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Widgets.textfield(ref, _titleController, '가든 이름',
                    '최대 12글자까지 쓸 수 있어요', null, StateProvider((ref) => null),
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
                                    .read(
                                        gardenColorSelectIndexProvider.notifier)
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
  const GardenAddDonePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (!context.mounted) return;
      context.pop();
      context.replaceNamed('bottom-navi');
    });
    return const Scaffold(
      body: Center(),
    );
  }
}
