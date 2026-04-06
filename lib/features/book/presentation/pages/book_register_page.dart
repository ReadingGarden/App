import 'package:book_flutter/app/navigation/bottom_navi_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'package:book_flutter/shared/utils/functions.dart';
import 'package:book_flutter/shared/constants/app_constant.dart';
import 'package:book_flutter/shared/utils/auto_input_formatter.dart';
import 'package:book_flutter/shared/theme/app_assets.dart';
import 'package:book_flutter/shared/theme/app_colors.dart';
import 'package:book_flutter/shared/widgets/app_widgets.dart';
import 'package:book_flutter/features/book/domain/entities/book_register_input_entity.dart';
import 'package:book_flutter/features/book/presentation/providers/book_register_provider.dart';
import 'package:book_flutter/features/garden/presentation/providers/garden_provider.dart'
    as garden_feature;
import 'package:book_flutter/gen/assets.gen.dart';

//가든 선택 인덱스 ...
final gardenSelectIndexProvider = StateProvider<int>((ref) => 0);
//꽃 선택 인덱스 ...
final flowerSelectIndexProvider = StateProvider<int>((ref) => 0);
final dateErrorProvider = StateProvider<String?>((ref) => null);

class BookRegisterPage extends ConsumerStatefulWidget {
  const BookRegisterPage({super.key, required this.book});

  final BookRegisterInputEntity book;

  @override
  ConsumerState<BookRegisterPage> createState() => _BookRegisterPageState();
}

class _BookRegisterPageState extends ConsumerState<BookRegisterPage> {
  final TextEditingController _dateController = TextEditingController();

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    Future.microtask(() {
      final gardens = ref.read(garden_feature.gardenListProvider);
      ref.read(gardenSelectIndexProvider.notifier).state = 0;
      ref.read(flowerSelectIndexProvider.notifier).state = 0;

      // 첫 실행 시 유효한 인덱스를 선택
      for (int i = 0; i < gardens.length; i++) {
        if (gardens[i].bookCount < 30) {
          ref.read(gardenSelectIndexProvider.notifier).state = i;
          break;
        }
      }
    });

    _dateController.text =
        Functions.formatBookReadDate(DateTime.now().toString());
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> submitBookRegistration() async {
    final gardens = ref.read(garden_feature.gardenListProvider);
    final result = await saveBookRegistration(
      ref,
      book: widget.book,
      gardens: gardens
          .map((garden) => {
                'garden_no': garden.gardenNo,
                'garden_title': garden.gardenTitle,
                'garden_color': garden.gardenColor,
                'book_count': garden.bookCount,
              })
          .toList(),
      selectedGardenIndex: ref.read(gardenSelectIndexProvider),
      selectedFlowerIndex: ref.read(flowerSelectIndexProvider),
      startDate: _dateController.text,
    );

    if (result.statusCode == 200 || result.statusCode == 201) {
      if (!mounted) {
        return;
      }
      ref.read(garden_feature.gardenNavigateToProvider.notifier).state = result.gardenNo;
      context.pushReplacementNamed('book-register-done',
          extra: result.gardenTitle);
    } else if (result.statusCode == 403) {
      Widgets.showToast(fToast, '꽉 찼어요! 다른 가든을 선택해주세요');
    }
  }

  //날짜 error
  void _validate() {
    if (_dateController.text.length == 10 || _dateController.text.isEmpty) {
      ref.read(dateErrorProvider.notifier).state = null;
    } else {
      ref.read(dateErrorProvider.notifier).state = 'YYYY.MM.DD 형식으로 적어주세요';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Widgets.appBar(context, title: '책 등록하기'),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                margin: EdgeInsets.only(bottom: 60.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.only(bottom: 12.h),
                        margin: EdgeInsets.only(left: 24.w, right: 24.w),
                        child: Row(children: [
                          (widget.book.cover != null && widget.book.cover != '')
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.book.cover!,
                                    width: 48.w,
                                    height: 64.h,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  width: 48.w,
                                  height: 64.h,
                                  decoration: BoxDecoration(
                                      color: AppColors.grey_F2,
                                      borderRadius: BorderRadius.circular(8.r)),
                                ),
                          Container(
                            margin: EdgeInsets.only(left: 12.w),
                            width: 252.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.book.title,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                  ),
                                ),
                                Text(
                                  widget.book.author,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.grey_8D),
                                ),
                              ],
                            ),
                          ),
                        ])),
                    Container(
                      height: 1.h,
                      color: AppColors.grey_F2,
                    ),
                    Container(
                        margin:
                            EdgeInsets.only(top: 30.h, left: 24.w, right: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '어느 가든에 심을까요?',
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold),
                            ),
                            _gardenList()
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 43.h, left: 24.w),
                        child: Text(
                          '어떤 꽃으로 자랄까요?',
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        )),
                    _flowerList(),
                    Container(
                        margin:
                            EdgeInsets.only(top: 40.h, left: 24.w, right: 24.w),
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 16.h),
                                child: Text(
                                  '언제 읽기 시작했나요?',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextField(
                                controller: _dateController,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                inputFormatters: [AutoInputFormatter()],
                                onChanged: (value) {
                                  // errorText 초기화
                                  ref.read(dateErrorProvider.notifier).state =
                                      null;
                                },
                                onTapOutside: (event) {
                                  _validate();
                                },
                                onSubmitted: (value) {
                                  _validate();
                                },
                                decoration: InputDecoration(
                                  counter: const Text(''),
                                  hintStyle: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.grey_8D),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide: const BorderSide(
                                        color: AppColors.grey_F2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide: const BorderSide(
                                        color: AppColors.grey_F2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide: const BorderSide(
                                        color: AppColors.grey_F2),
                                  ),
                                  errorText: ref.watch(dateErrorProvider),
                                  errorStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.errorRedColor,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide(
                                          color: AppColors.errorRedColor,
                                          width: 1.w)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide(
                                          color: AppColors.errorRedColor,
                                          width: 1.w)),
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              )),
        ),
        bottomNavigationBar: Widgets.bottomBar(context, child: Widgets.button('등록하기', true, () {
              submitBookRegistration();
            })));
  }

  Widget _gardenList() {
    final gardens = ref.watch(garden_feature.gardenListProvider);

    return Container(
      margin: EdgeInsets.only(top: 16.h),
      height: (68.h + 10.h) * gardens.length,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          gardens.length,
          (index) {
            final garden = gardens[index];
            return GestureDetector(
              onTap: () {
                // 북 카운트가 30이 아닌 경우에만 선택 가능
                if (garden.bookCount < 30) {
                  ref.read(gardenSelectIndexProvider.notifier).state = index;
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
                            color:
                                (index == ref.watch(gardenSelectIndexProvider))
                                    ? AppColors.black_59
                                    : AppColors.grey_F2),
                        color: (garden.bookCount < 30)
                            ? Colors.white
                            : AppColors.grey_F2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          garden.gardenTitle,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: (garden.bookCount < 30)
                                  ? Colors.black
                                  : AppColors.grey_8D),
                        ),
                        Text(
                          '심은 꽃 ${garden.bookCount}/30',
                          style: TextStyle(
                              fontSize: 12.sp, color: AppColors.grey_8D),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20.w),
                    child: AppAssets.iconBookmarkFull.svg(
                      width: 20.h,
                      height: 24.h,
                      colorFilter: ColorFilter.mode(
                        Functions.gardenColor(garden.gardenColor),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _flowerList() {
    return Container(
      margin: EdgeInsets.only(top: 13.h),
      height: 152.h,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: List.generate(
          Constant.FLOWER_LIST.length,
          (index) {
            return GestureDetector(
              onTap: () {
                ref.read(flowerSelectIndexProvider.notifier).state = index;
              },
              child: Padding(
                padding:
                    EdgeInsets.only(right: 8.w, left: (index == 0) ? 24.w : 0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      width: 120.r,
                      height: 120.r,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                              color: (index ==
                                      ref.watch(flowerSelectIndexProvider))
                                  ? Colors.black
                                  : AppColors.grey_F2),
                          color: Colors.transparent),
                      child: AppAssets.selectFlower(
                        Constant.FLOWER_LIST[index],
                      ).image(),
                    ),
                    SizedBox(
                      height: 24.h,
                      child: Text(
                        Constant.FLOWER_LIST[index],
                        style: TextStyle(
                            fontSize: 14.sp,
                            color:
                                (index == ref.watch(flowerSelectIndexProvider))
                                    ? Colors.black
                                    : AppColors.grey_8D),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BookRegisterDonePage extends ConsumerWidget {
  const BookRegisterDonePage({super.key, required this.gardenName});

  final String gardenName;

  void _goToGarden(BuildContext context, WidgetRef ref) async {
    ref.read(currentIndexProvider.notifier).state = 0;
    ref.read(garden_feature.gardenVisitCountProvider.notifier).state++;
    final targetGardenNo = ref.read(garden_feature.gardenNavigateToProvider);
    if (targetGardenNo != null) {
      await garden_feature.updateMainGarden(ref, targetGardenNo);
      ref.read(garden_feature.gardenNavigateToProvider.notifier).state = null;
    }
    context.go('/bottom-navi');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 142.h),
          child: Center(
            child: Column(
              children: [
                Text.rich(
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.33.h),
                    TextSpan(children: [
                      TextSpan(
                          text: gardenName,
                          style:
                              const TextStyle(color: AppColors.primaryColor)),
                      const TextSpan(text: '에')
                    ])),
                Text(
                  '새로운 책을 심었어요',
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.33.h),
                ),
                Container(
                  margin: EdgeInsets.only(top: 62.h),
                  width: 260.r,
                  height: 260.r,
                  child: Assets.images.bookRegister.image(),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Widgets.bottomBar(context, child: Widgets.button('가든으로 가기', true, () {
            _goToGarden(context, ref);
          }),
        ));
  }
}
