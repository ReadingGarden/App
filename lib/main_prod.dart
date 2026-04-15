import 'package:book_flutter/core/flavor/flavor_config.dart';
import 'package:book_flutter/main.dart';

void main() async {
  FlavorConfig.setFlavor(Flavor.prod);
  await runMainApp();
}
