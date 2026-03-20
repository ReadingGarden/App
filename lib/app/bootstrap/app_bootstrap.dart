import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../../firebase_options.dart';
import '../../utils/Functions.dart';

Future<void> bootstrapApplication() async {
  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: 'a4fcc9bb270d51847a1ae05d63619bda',
  );

  await Functions.requestPermissions();
  await FlutterBranchSdk.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
