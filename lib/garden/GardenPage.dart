import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/service/GardenService.dart';

final gardenListProvider = StateProvider<List>((ref) => []);

class GardenPage extends ConsumerStatefulWidget {
  @override
  _GardenPageState createState() => _GardenPageState();
}

class _GardenPageState extends ConsumerState<GardenPage> {
  @override
  void initState() {
    super.initState();
    getGardenLsit();
  }

  //가든 리스트 조회 api
  void getGardenLsit() async {
    final response = await gardenService.getGardenList();
    if (response?.statusCode == 200) {
      ref.read(gardenListProvider.notifier).state = response?.data['data'];
    } else if (response?.statusCode == 401) {
      print('토큰에러');
    }
  }

  @override
  Widget build(BuildContext context) {
    final gardenList = ref.watch(gardenListProvider);

    return Scaffold(
      body: Center(child: Text(gardenList.toString())),
    );
  }
}
