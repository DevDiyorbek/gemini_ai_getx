import 'package:gemini_ai_prototype/presentation/controllers/start_controller.dart';
import 'package:get/get.dart';

import '../../presentation/controllers/home_controller.dart';


class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StartController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}