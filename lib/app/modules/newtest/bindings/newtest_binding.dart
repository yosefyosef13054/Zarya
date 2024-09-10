import 'package:get/get.dart';

import '../controllers/newtest_controller.dart';

class NewtestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewtestController>(
      () => NewtestController(),
    );
  }
}
