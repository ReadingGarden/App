import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:intl/intl.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Constant.dart';

class Functions {
  //이메일 유효성 검사
  static bool emailValidation(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  //DateTime -> String 변환(HH:mm)
  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  //String(HH:mm) -> DateTime 변환
  static DateTime formatString(String timeString) {
    DateFormat dateFormat = DateFormat('HH:mm');
    return dateFormat.parse(timeString);
  }

  //String(DateTime) -> String 변환(yyyy년 MM월 dd일)
  static String formatDate(String dateTimeString) {
    // String -> DateTime
    DateTime dateTime = DateTime.parse(dateTimeString);
    // DateTime -> String
    String formattedDate = DateFormat('yyyy년 MM월 dd일').format(dateTime);
    return formattedDate;
  }

  //String(yyyy.MM.dd) -> DateTime 변환
  static DateTime formatBookReadString(String timeString) {
    DateFormat dateFormat = DateFormat('yyyy.MM.dd');
    return dateFormat.parse(timeString);
  }

  //String(DateTime) -> String 변환(yyyy.MM.dd)
  static String formatBookReadDate(String dateTimeString) {
    // String -> DateTime
    DateTime dateTime = DateTime.parse(dateTimeString);
    // DateTime -> String
    String formattedDate = DateFormat('yyyy.MM.dd').format(dateTime);
    return formattedDate;
  }

  //가든 컬러
  static Color gardenColor(String color) {
    int colorIndex = Constant.GARDEN_COLOR_LIST.indexOf(color);
    return Constant.GARDEN_COLOR_SET_LIST[colorIndex];
  }

  //가든 배경 컬러
  static Color gardenBackColor(String color) {
    int colorIndex = Constant.GARDEN_COLOR_LIST.indexOf(color);
    return Constant.GARDEN_CHIP_COLOR_SET_LIST[colorIndex];
  }

  //책 상태
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

  //권한 요청
  static Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      // Permission.microphone
    ].request();

    // 상태 확인
    print('Camera permission status: ${statuses[Permission.camera]}');
    print('Storage permission status: ${statuses[Permission.storage]}');
    // print('Microphone permission status: ${statuses[Permission.microphone]}');
  }

  //권한 확인 및 요청
  static Future<void> checkAndRequestPermissions(Function function) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      // Permission.microphone
    ].request();

    print(statuses);

    if (statuses[Permission.camera]!.isGranted &&
            statuses[Permission.storage]!.isGranted
        // && statuses[Permission.microphone]!.isGranted
        ) {
      // 권한이 이미 부여됨
      function();
    } else {
      // 권한이 부여되지 않음, 요청
      statuses = await [
        Permission.camera,
        Permission.storage,
        // Permission.microphone
      ].request();

      if (statuses[Permission.camera]!.isGranted &&
              statuses[Permission.storage]!.isGranted
          // && statuses[Permission.microphone]!.isGranted
          ) {
        // 권한이 부여됨
        function();
      } else if (statuses[Permission.camera]!.isPermanentlyDenied ||
              statuses[Permission.storage]!.isPermanentlyDenied
          // || statuses[Permission.microphone]!.isPermanentlyDenied
          ) {
        // 권한이 영구적으로 거부됨, 설정으로 이동
        await openAppSettings();
        // 상태를 다시 확인
        Map<Permission, PermissionStatus> newStatuses = await [
          Permission.camera,
          Permission.storage,
          // Permission.microphone
        ].request();

        if (newStatuses[Permission.camera]!.isGranted &&
                newStatuses[Permission.storage]!.isGranted
            // &&newStatuses[Permission.microphone]!.isGranted
            ) {
          function();
        } else {
          print('권한이 여전히 부여되지 않았습니다.');
        }
      } else {
        // 권한이 거부되었으나 영구적이지 않음
        statuses = await [
          Permission.camera,
          Permission.storage,
          Permission.microphone
        ].request();

        if (statuses[Permission.camera]!.isGranted &&
                statuses[Permission.storage]!.isGranted
            // && statuses[Permission.microphone]!.isGranted
            ) {
          // 권한이 부여됨
          function();
        } else {
          print('권한 요청이 거부되었습니다.');
        }
      }
    }
  }

  //URL 링크 열기
  static Future<void> launchURL(String url) async {
    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  //초대 링크 생성 (시스템 공유)
  static Future<void> shareBranchLink(String garden, int garden_no) async {
    BranchUniversalObject buo = BranchUniversalObject(
      canonicalIdentifier: 'flutter/branch',
      title: '$garden에 초대합니다🪴',
      contentDescription: '독서가든에서 가드너들과 함께 책을 읽고 기록해봐요!',
      // 사용자 정의 파라미터 추가 (contentMetadata 사용)
      contentMetadata: BranchContentMetaData()
        ..addCustomMetadata('garden_no', garden_no),
    );

    BranchLinkProperties linkProperties = BranchLinkProperties(
      // channel: 'kakao',
      feature: 'sharing',
    );

    BranchResponse response = await FlutterBranchSdk.getShortUrl(
        buo: buo, linkProperties: linkProperties);

    if (response.success) {
      Share.share(response.result.toString());
    }
  }

  //초대 링크 생성
  static Future<void> createBranchLink2() async {
    BranchUniversalObject buo = BranchUniversalObject(
      canonicalIdentifier: 'flutter/branch',
      title: '독서가든',
      contentDescription: '{독서가든}에 초대',
      // 사용자 정의 파라미터 추가 (contentMetadata 사용)
      contentMetadata: BranchContentMetaData()
        ..addCustomMetadata('garden', '가든')
        ..addCustomMetadata('garden_no', '17'),
    );

    BranchLinkProperties linkProperties = BranchLinkProperties(
      // channel: 'kakao',
      feature: 'sharing',
    );

    BranchResponse response = await FlutterBranchSdk.getShortUrl(
        buo: buo, linkProperties: linkProperties);

    if (response.success) {
      print('Generated Branch Link: ${response.result}');
      // 이 링크를 카카오톡에서 공유
      await Functions.kakaoShare(response.result, 'garden');
      ;
    } else {
      print('Error: ${response.errorMessage}');
    }
  }

  //카카오톡 공유
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
        // Button(
        //   title: '웹으로 보기',
        //   link: Link(
        //     webUrl: Uri.parse(deepLinkUrl),
        //     mobileWebUrl: Uri.parse(deepLinkUrl),
        //   ),
        // ),
        Button(
          title: '앱으로보기',
          link: Link(
            androidExecutionParams: {'garden_no': 'value1'},
            iosExecutionParams: {'garden_no': 'value1'},
          ),
        ),
      ],
    );
    // 카카오톡 실행 가능 여부 확인
    bool isKakaoTalkSharingAvailable =
        await ShareClient.instance.isKakaoTalkSharingAvailable();

    if (isKakaoTalkSharingAvailable) {
      try {
        Uri uri =
            await ShareClient.instance.shareDefault(template: defaultFeed);
        await ShareClient.instance.launchKakaoTalk(uri);
        print('카카오톡 공유 완료');
      } catch (error) {
        print('카카오톡 공유 실패 $error');
      }
    } else {
      try {
        Uri shareUrl = await WebSharerClient.instance
            .makeDefaultUrl(template: defaultFeed);
        await launchBrowserTab(shareUrl, popupOpen: true);
      } catch (error) {
        print('카카오톡 공유 실패 $error');
      }
    }

    // // 사용자 정의 템플릿 ID
    // int templateId = 111641;
    // // 카카오톡 실행 가능 여부 확인
    // bool isKakaoTalkSharingAvailable =
    //     await ShareClient.instance.isKakaoTalkSharingAvailable();

    // if (isKakaoTalkSharingAvailable) {
    //   try {
    //     Uri uri = await ShareClient.instance
    //         .shareCustom(templateId: templateId, templateArgs: {
    //       'link': branchLink,
    //       'garden': garden,
    //       'link_click_id': '17' // 여기에 17을 전달
    //     });
    //     await ShareClient.instance.launchKakaoTalk(uri);
    //     print('카카오톡 공유 완료');
    //   } catch (error) {
    //     print('카카오톡 공유 실패 $error');
    //   }
    // } else {
    //   try {
    //     Uri shareUrl = await WebSharerClient.instance
    //         .makeCustomUrl(templateId: templateId, templateArgs: {
    //       'link': branchLink,
    //       'garden': garden,
    //       'link_click_id': '17', // 여기에 17을 전달
    //     });
    //     await launchBrowserTab(shareUrl, popupOpen: true);
    //   } catch (error) {
    //     print('카카오톡 공유 실패 $error');
    //   }
    // }

    // try {
    //   // 카카오톡 공유 템플릿 설정
    //   Map<String, String> templateArgs = {
    //     'garden': garden,
    //     'link': link,
    //     // 'link_click_id': '17',       // 추가 파라미터
    //     // 'link': link,                // Branch 링크 포함
    //     'androidExecutionParams':
    //         'garden=value1&key2=value2', // Android 실행 파라미터
    //     'iosExecutionParams': 'garden=value1&key2=value2', // iOS 실행 파라미터
    //     // 'I_E': link // Branch 링크
    //   };

    //   // 템플릿 ID를 실제 사용하는 카카오톡 템플릿 ID로 설정
    //   int templateId = 111641;

    //   // 카카오톡 템플릿 공유
    //   Uri uri = await ShareClient.instance.shareCustom(
    //     templateId: templateId,
    //     templateArgs: templateArgs,
    //   );

    //   // 카카오톡 실행
    //   await ShareClient.instance.launchKakaoTalk(uri);
    //   print('카카오톡 공유 완료');
    // } catch (error) {
    //   print('카카오톡 공유 실패: $error');
    // }
  }
}
