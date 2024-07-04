import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/provider/TokenProvider.dart';
import '../utils/Functions.dart';

class GardenPage extends ConsumerStatefulWidget {
  @override
  _GardenPageState createState() => _GardenPageState();
}

class _GardenPageState extends ConsumerState<GardenPage> {
  @override
  void initState() {
    super.initState();
    Functions.getAccess(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(ref.watch(TokenProvider.accessProvider) ?? 'null')),
    );
  }
}
