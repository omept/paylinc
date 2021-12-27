import 'package:get/get.dart';
import 'package:paylinc/features/create_wallet/controller/create_wallet_controller.dart';

class CreateWalletBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateWalletController());
  }
}
