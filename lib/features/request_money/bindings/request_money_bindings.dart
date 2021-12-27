import 'package:get/get.dart';
import 'package:paylinc/features/request_money/controller/request_money_controller.dart';

class RequestMoneyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RequestMoneyController());
  }
}
