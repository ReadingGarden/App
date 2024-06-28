import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/provider/ResponseProvider.dart';
import '../utils/Widgets.dart';

class ProfilePage extends ConsumerStatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userResponse = ref.watch(userResponseProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '프로필'),
      body: Container(
        child: Text('$userResponse'),
      ),
    );
  }
}
