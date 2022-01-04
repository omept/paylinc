library app_helpers;

import 'package:authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:paylinc/shared_components/models/response_model.dart';
import 'package:paylinc/utils/controllers/auth_controller.dart';
import 'package:paylinc/utils/services/local_storage_services.dart';
import 'package:user_repository/user_repository.dart';

part 'string_helper.dart';
part 'type.dart';
part 'snackbar.dart';
part 'on_authenticated.dart';

extension IntHumanFormat on int {
  String intHumanFormat() {
    return this.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}

extension DoubleHumanFormat on double {
  String doubleHumanFormat() {
    return this.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}
