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
  // dev flavor에서는 Branch TEST 키를 사용하도록 init
  await FlutterBranchSdk.init(useTestKey: FlavorConfig.isDev);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
