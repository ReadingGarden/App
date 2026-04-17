import 'dart:io';

import 'package:book_flutter/core/logger.dart';
import 'package:book_flutter/features/app/data/services/app_service.dart';
import 'package:book_flutter/shared/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// 버전 문자열 비교 (예: "1.1.0" < "1.1.1")
bool _isVersionLower(String current, String min) {
  final currentParts = current.split('.').map(int.parse).toList();
  final minParts = min.split('.').map(int.parse).toList();

  for (int i = 0; i < minParts.length; i++) {
    final c = i < currentParts.length ? currentParts[i] : 0;
    final m = minParts[i];
    if (c < m) return true;
    if (c > m) return false;
  }
  return false;
}

/// 서버에서 최소 버전을 조회하고, 현재 버전이 낮으면 강제 업데이트 바텀시트 표시.
/// 업데이트 필요 시 true 반환.
Future<bool> checkForceUpdate(BuildContext context) async {
  try {
    final response = await appService.getMinVersion();
    if (response == null || response.statusCode != 200) return false;

    final minVersion = response.data['data']['min_version'] as String?;
    if (minVersion == null) return false;

    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;

    logger.d('현재 버전: $currentVersion, 최소 버전: $minVersion');

    if (_isVersionLower(currentVersion, minVersion)) {
      if (!context.mounted) return true;
      await showForceUpdateSheet(context);
      return true;
    }
  } catch (e) {
    logger.e('버전 체크 실패: $e');
  }
  return false;
}

Future<void> showForceUpdateSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    useSafeArea: true,
    isDismissible: false,
    enableDrag: false,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: Container(
          margin: EdgeInsets.only(
            top: 30.h,
            left: 24.w,
            right: 24.w,
            bottom: 16.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '업데이트 안내',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(top: 6.h, bottom: 24.h),
                child: Text(
                  '새로운 버전이 출시되었습니다.\n원활한 사용을 위해 업데이트해주세요.',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
              Widgets.button('업데이트', true, () {
                final url = Platform.isIOS
                    ? 'https://apps.apple.com/app/id<APP_ID>'
                    : 'https://play.google.com/store/apps/details?id=com.dokseogarden';
                launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
              }),
            ],
          ),
        ),
      );
    },
  );
}
