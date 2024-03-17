import 'package:example/foundation/config/app_config.dart';

import 'bootstrap/kernel.dart';

void main() async {
  final Kernel kernel = Kernel(appConfig: AppConfig.fromEnvironment());

  await kernel.bootstrap();

  kernel.run();
}
