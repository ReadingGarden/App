import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../utils/SharedPreferences.dart';

class GardenPage extends ConsumerWidget {
  test() async {
    // final refresh = await loadRefresh();
    // print(refresh);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => test(),
        child: Center(child: Text('ddfdfdfsfdsfsdd')),
      ),
    );
  }
}
