import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:ssk_ruamjai/controllers/navbar_menu_controller.dart';

class OperationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavBarMenuController>(
      () => NavBarMenuController(),
    );
  }
}
