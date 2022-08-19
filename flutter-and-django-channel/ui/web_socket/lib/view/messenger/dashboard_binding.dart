import 'package:get/get.dart';
import 'controller/chat_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ChatController());
  }
}
