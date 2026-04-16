import 'package:book_flutter/core/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'package:book_flutter/shared/utils/functions.dart';
import '../../firebase_options.dart';

Future<void> bootstrapApplication() async {
  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: 'a4fcc9bb270d51847a1ae05d63619bda',
  );

  await Functions.requestPermissions();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (_) {}

  try {
    await FlutterBranchSdk.init().timeout(
      const Duration(seconds: 5),
      onTimeout: () => logger.w('Branch init 타임아웃'),
    );
  } catch (e) {
    logger.e('Branch init 실패: $e');
  }
}
