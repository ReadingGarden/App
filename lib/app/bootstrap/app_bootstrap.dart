import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'package:book_flutter/core/flavor/flavor_config.dart';
import 'package:book_flutter/shared/utils/functions.dart';
import '../../firebase_options.dart';

Future<void> bootstrapApplication() async {
  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: 'a4fcc9bb270d51847a1ae05d63619bda',
  );

  await Functions.requestPermissions();
  // Branch 초기화 (dev/prod 키 분리는 Info.plist, AndroidManifest.xml에서 설정)
  await FlutterBranchSdk.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
