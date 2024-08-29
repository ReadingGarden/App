import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../core/service/BookService.dart';
import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

final barcodeImageFileProvider = StateProvider<File?>((ref) => null);
final barcodeValueProvider = StateProvider<String>((ref) => '');

class BookBarcodePage extends ConsumerStatefulWidget {
  _BookBarcodePageState createState() => _BookBarcodePageState();
}

class _BookBarcodePageState extends ConsumerState<BookBarcodePage> {
  final ImagePicker _picker = ImagePicker();
  final BarcodeScanner _barcodeScanner = BarcodeScanner();

  late FToast fToast;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(barcodeImageFileProvider.notifier).state = null;
      ref.read(barcodeValueProvider.notifier).state = '';
    });

    fToast = FToast();
    fToast.init(context);
  }

  //책 상세조회 isbn api
  void getDetailBook_ISBN(String isbn) async {
    final response = await bookService.getDetailBook_ISBN(isbn);
    if (response?.statusCode == 200) {
      context.pushNamed('book-add-garden', extra: isbn);
    } else if (response?.statusCode == 401) {
      //500에러
    } else {
      fToast.showToast(child: Widgets.toast('📚 바코드가 등록되지 않은 책이에요'));
    }
  }

  Future<void> _takePictureAndScanBarcode() async {
    ref.read(barcodeImageFileProvider.notifier).state = null;
    ref.read(barcodeValueProvider.notifier).state = '';

    try {
      // 사진 찍기
      final XFile? picture =
          await _picker.pickImage(source: ImageSource.camera);
      if (picture == null) return;

      final Directory appDirectory = await getApplicationDocumentsDirectory();
      final String pictureDirectory = '${appDirectory.path}/Pictures';
      await Directory(pictureDirectory).create(recursive: true);
      final String filePath =
          '$pictureDirectory/${DateTime.now().millisecondsSinceEpoch}.png';

      // 이미지 파일 저장
      final File imageFile = File(picture.path);
      await imageFile.copy(filePath);

      // UI에 이미지 표시
      ref.read(barcodeImageFileProvider.notifier).state = imageFile;

      // 이미지를 InputImage로 변환
      final InputImage inputImage = InputImage.fromFile(imageFile);

      // 바코드 스캔
      final List<Barcode> barcodes =
          await _barcodeScanner.processImage(inputImage);

      // 바코드 결과 처리
      ref.read(barcodeValueProvider.notifier).state = barcodes.isNotEmpty
          ? barcodes.first.displayValue ?? ''
          : 'No barcode detected';

      print(
          '--------------------------------------------------------------------------------');
      print(barcodes.first.displayValue);

      if (ref.watch(barcodeValueProvider).isNotEmpty &&
          ref.watch(barcodeValueProvider) != 'No barcode detected') {
        getDetailBook_ISBN(ref.watch(barcodeValueProvider));
      } else {
        fToast.showToast(child: Widgets.toast('🔎 바코드가 인식되지 않았어요'));
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final barcodeImageFile = ref.watch(barcodeImageFileProvider);
    final barcodeValue = ref.watch(barcodeValueProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '바코드로 검색하기'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.file(barcodeImageFile!),
            // barcodeImageFile != null
            //     ? Image.file(barcodeImageFile)
            //     : Text('No image selected.'),
            SvgPicture.asset(
              'assets/images/barcode.svg',
              width: 160.r,
              height: 160.r,
            ),
            Padding(
              padding: EdgeInsets.only(top: 36.h, bottom: 6.h),
              child: Text(
                '바코드로 책 추가하기',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              '바코드를 찍으면 자동으로 책이 등록되어요\ntip. 바코드는 주로 책 뒷면에 있어요',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.grey_8D),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
        child: Widgets.button('촬영하기', true, _takePictureAndScanBarcode),
      ),
    );
  }
}
