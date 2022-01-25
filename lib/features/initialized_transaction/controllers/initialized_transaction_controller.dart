part of initialized_transaction;

class InitializedTransactionController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var intlzdTrnscnB64Url = InitializedTransactionB64().obs;
  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void onInit() {
    super.onInit();
    var b64UrlStr = Get.parameters['b64UrlStr'];
    // print(b64UrlStr);
    // print('b64UrlStr');
  }
}
