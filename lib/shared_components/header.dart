import 'package:flutter/material.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/search_field.dart';
import 'package:paylinc/shared_components/today_text.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const TodayText(),
        const SizedBox(width: kSpacing),
        Expanded(child: SearchField()),
      ],
    );
  }
}
