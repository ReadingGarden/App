import 'package:book_flutter/utils/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final testProvider = StateProvider<String?>((ref) => null);

class GardenPage extends ConsumerStatefulWidget {
  @override
  _GardenPageState createState() => _GardenPageState();
}

class _GardenPageState extends ConsumerState<GardenPage> {
  @override
  void initState() {
    super.initState();
    test();
  }

  test() async {
    final testNotifier = ref.read(testProvider.notifier);

    testNotifier.state = await loadAccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => test(),
        child: Center(child: Text(ref.watch(testProvider) ?? 'null')),
      ),
    );
  }
}
