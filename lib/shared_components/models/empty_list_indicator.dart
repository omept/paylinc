import 'package:flutter/material.dart';
import 'package:paylinc/constants/app_constants.dart';

Widget emptyListIndicator() {
  return Center(
      child: Padding(
    padding: const EdgeInsets.only(top: kSpacing * 2),
    child: Text("Empty"),
  ));
}
