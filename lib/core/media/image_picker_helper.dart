import 'package:image_picker/image_picker.dart';

/// 업로드용 이미지 선택 헬퍼.
///
/// 기기에서 고른 원본 사진은 4000px 이상, 수 MB에 달하는 경우가 많아
/// 업로드 전에 긴 변 1440px 이내로 축소한다.
/// 리사이징은 image_picker가 플랫폼 네이티브로 처리하며 가로/세로 비율은 유지된다.
class AppImagePicker {
  AppImagePicker._();

  /// 긴 변 기준 최대 픽셀. 가로/세로 사진 모두 1440px을 넘지 않는다.
  ///
  /// 메모 사진의 최대 표시 크기는 상세 화면의 320.w로, 고DPI 기기(412dp/3.5x)
  /// 기준 약 1280px이다. 전체화면/확대 보기가 없어 1440px이면 충분하다.
  /// 확대 보기를 추가한다면 1920px 이상으로 올려야 한다.
  static const double _maxDimension = 1440;

  /// JPEG 재인코딩 품질 (0~100).
  static const int _quality = 85;

  static final ImagePicker _picker = ImagePicker();

  /// 갤러리에서 이미지를 고른다. 취소하면 null.
  static Future<XFile?> pickFromGallery() => _pick(ImageSource.gallery);

  /// 카메라로 촬영한다. 취소하면 null.
  static Future<XFile?> takePhoto() => _pick(ImageSource.camera);

  static Future<XFile?> _pick(ImageSource source) => _picker.pickImage(
    source: source,
    maxWidth: _maxDimension,
    maxHeight: _maxDimension,
    imageQuality: _quality,
  );
}
