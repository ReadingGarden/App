import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:intl/intl.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_constant.dart';

class Functions {
  static bool emailValidation(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  static DateTime formatString(String timeString) {
    DateFormat dateFormat = DateFormat('HH:mm');
    return dateFormat.parse(timeString);
  }

  static String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('yyyy년 MM월 dd일').format(dateTime);
    return formattedDate;
  }

  static DateTime formatBookReadString(String timeString) {
    DateFormat dateFormat = DateFormat('yyyy.MM.dd');
    return dateFormat.parse(timeString);
  }

  static String formatBookReadDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('yyyy.MM.dd').format(dateTime);
    return formattedDate;
  }

  static String getPostpositionString(String word, String case1, String case2) {
    final codeUnit = word.codeUnits.last;
    if (codeUnit >= 0xAC00 && codeUnit <= 0xD7A3) {
      final hasJongseong = (codeUnit - 0xAC00) % 28 != 0;
      return hasJongseong ? case1 : case2;
    }
    return case2;
  }

  static Color gardenColor(String color) {
    int colorIndex = Constant.GARDEN_COLOR_LIST.indexOf(color);
    return Constant.GARDEN_COLOR_SET_LIST[colorIndex];
  }

  static Color gardenBackColor(String color) {
    int colorIndex = Constant.GARDEN_COLOR_LIST.indexOf(color);
    return Constant.GARDEN_BACK_COLOR_SET_LIST[colorIndex];
  }

  static String bookStatusString(int status) {
    String statusString = '읽고있어요';
    switch (status) {
      case 0:
        break;
      case 1:
        statusString = '다읽었어요';
      case 2:
        statusString = '읽고싶어요';
    }
    return statusString;
  }

  static Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.notification
    ].request();

    debugPrint('카메라 권한 상태: ${statuses[Permission.camera]}');
    debugPrint('저장소 권한 상태: ${statuses[Permission.storage]}');
    debugPrint('알림 권한 상태: ${statuses[Permission.notification]}');
  }

  static Future<void> checkAndRequestPermissions(Function function) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();

    debugPrint('권한 요청 결과: $statuses');

    if (statuses[Permission.camera]!.isGranted &&
        statuses[Permission.storage]!.isGranted) {
      function();
    } else {
      statuses = await [
        Permission.camera,
        Permission.storage,
      ].request();

      if (statuses[Permission.camera]!.isGranted &&
          statuses[Permission.storage]!.isGranted) {
        function();
      } else if (statuses[Permission.camera]!.isPermanentlyDenied ||
          statuses[Permission.storage]!.isPermanentlyDenied) {
        await openAppSettings();
        Map<Permission, PermissionStatus> newStatuses = await [
          Permission.camera,
          Permission.storage,
        ].request();

        if (newStatuses[Permission.camera]!.isGranted &&
            newStatuses[Permission.storage]!.isGranted) {
          function();
        } else {
          debugPrint('권한이 설정 화면에서도 부여되지 않았습니다.');
        }
      } else {
        statuses = await [
          Permission.camera,
          Permission.storage,
          Permission.microphone
        ].request();

        if (statuses[Permission.camera]!.isGranted &&
            statuses[Permission.storage]!.isGranted) {
          function();
        } else {
          debugPrint('권한 요청이 거부되었습니다.');
        }
      }
    }
  }

  static Future<void> launchURL(String url) async {
    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchURLTest(String url) async {
    await launchURL(url);
  }

  static Future<void> shareBranchLink(String garden, int gardenNo) async {
    BranchUniversalObject buo = BranchUniversalObject(
      canonicalIdentifier: 'flutter/branch',
      title: '$garden에 초대합니다🪴',
      contentDescription: '독서가든에서 함께 책을 읽고 기록해봐요!',
      contentMetadata: BranchContentMetaData()
        ..addCustomMetadata('garden_no', gardenNo),
    );

    BranchLinkProperties linkProperties = BranchLinkProperties(
      feature: 'sharing',
    );

    BranchResponse response = await FlutterBranchSdk.getShortUrl(
        buo: buo, linkProperties: linkProperties);

    if (response.success) {
      Share.share(response.result.toString());
    }
  }

  static Future<String?> createInviteLink(int gardenNo) async {
    BranchUniversalObject buo = BranchUniversalObject(
      canonicalIdentifier: 'flutter/branch',
      title: '독서가든에 초대합니다🪴',
      contentDescription: '독서가든에서 함께 책을 읽고 기록해봐요!',
      contentMetadata: BranchContentMetaData()
        ..addCustomMetadata('garden_no', gardenNo),
    );

    BranchLinkProperties linkProperties = BranchLinkProperties(
      feature: 'sharing',
    );

    BranchResponse response = await FlutterBranchSdk.getShortUrl(
        buo: buo, linkProperties: linkProperties);

    if (response.success) {
      return response.result.toString();
    }
    return null;
  }

  static Future<void> createBranchLink2() async {
    BranchUniversalObject buo = BranchUniversalObject(
      canonicalIdentifier: 'flutter/branch',
      title: '독서가든',
      contentDescription: '{독서가든}에 초대',
      contentMetadata: BranchContentMetaData()
        ..addCustomMetadata('garden', '가든')
        ..addCustomMetadata('garden_no', '17'),
    );

    BranchLinkProperties linkProperties = BranchLinkProperties(
      feature: 'sharing',
    );

    BranchResponse response = await FlutterBranchSdk.getShortUrl(
        buo: buo, linkProperties: linkProperties);

    if (response.success) {
      debugPrint('초대 링크 생성 성공: ${response.result}');
      await Functions.kakaoShare(response.result, 'garden');
    } else {
      debugPrint('초대 링크 생성 실패: ${response.errorMessage}');
    }
  }

  static kakaoShare(String deepLinkUrl, String garden) async {
    final FeedTemplate defaultFeed = FeedTemplate(
      content: Content(
        title: '딸기 치즈 케익',
        description: '#케익 #딸기 #삼평동 #카페 #분위기 #소개팅',
        imageUrl: Uri.parse(
            'https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png'),
        link: Link(
            webUrl: Uri.parse(deepLinkUrl),
            mobileWebUrl: Uri.parse(deepLinkUrl)),
      ),
      social: Social(likeCount: 286, commentCount: 45, sharedCount: 845),
      buttons: [
        Button(
          title: '웹으로 보기',
          link: Link(
            webUrl: Uri.parse(deepLinkUrl),
            mobileWebUrl: Uri.parse(deepLinkUrl),
          ),
        ),
      ],
    );

    bool isKakaoTalkSharingAvailable =
        await ShareClient.instance.isKakaoTalkSharingAvailable();

    if (isKakaoTalkSharingAvailable) {
      try {
        Uri uri =
            await ShareClient.instance.shareDefault(template: defaultFeed);
        await launchBrowserTab(uri, popupOpen: true);
      } catch (error) {
        debugPrint('카카오톡 공유 실행 실패: $error');
      }
    } else {
      try {
        Uri shareUrl = await WebSharerClient.instance
            .makeDefaultUrl(template: defaultFeed);
        await launchBrowserTab(shareUrl, popupOpen: true);
      } catch (error) {
        debugPrint('웹 공유 링크 실행 실패: $error');
      }
    }
  }

  static Future<void> captureWidget(
      GlobalKey widgetKey, Function(Uint8List?) onCaptured) async {
    RenderRepaintBoundary boundary =
        widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    onCaptured(pngBytes);
  }
}
