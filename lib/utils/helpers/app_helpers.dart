library app_helpers;

import 'dart:convert';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paylinc/shared_components/shared_components.dart';
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';
import 'package:paylinc/utils/services/local_storage_services.dart';
import 'package:user_repository/user_repository.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:flutter/services.dart';

part 'string_helper.dart';
part 'snackbar.dart';
part 'on_authenticated.dart';
part 'b64_encoder.dart';
part 'date_time_display.dart';
part 'get_profile.dart';
part 'is_text_an_integer.dart';
part 'thousand_separator_formatter.dart';

extension IntHumanFormat on int {
  String intHumanFormat() {
    return _humanFormat(toStringAsFixed(2));
  }
}

extension ToShortHumanFormat on String {
  String toShortHumanFormat({String? currency}) {
    return canBeInteger(toString()) || canBeDouble(toString())
        ? _shortHumanFormat(val: toString(), currency: currency)
        : '';
  }
}

extension ToHumanFormat on String {
  String toHumanFormat({String? currency}) {
    return canBeInteger(toString()) || canBeDouble(toString())
        ? "${currency ?? ""} ${_humanFormat(toString())}"
        : '';
  }
}

extension DoubleHumanFormat on double {
  String doubleHumanFormat() {
    return _humanFormat(toStringAsFixed(2));
  }
}

String _humanFormat(String val) {
  return val.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}

String _shortHumanFormat({dynamic val, String? currency}) {
  return NumberFormat.compactCurrency(
    decimalDigits: 2,
    symbol: currency ?? '',
  ).format(double.parse(val));
}

Widget appVersion(ThemeData td) {
  String year = DateFormat('yyyy').format(DateTime.now());
  return Column(children: [
    Center(
      child: Text(
        "Made with love",
        style: TextStyle(
          fontSize: 14,
          color: td.textTheme.caption?.color,
        ),
      ),
    ),
    Center(
      child: Text(
        " © $year",
        style: TextStyle(
          fontSize: 14,
          color: td.textTheme.caption?.color,
        ),
      ),
    )
  ]);
}
