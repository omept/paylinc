import 'package:flutter/material.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/search_field.dart';
import 'package:paylinc/shared_components/today_text.dart';

class Header extends StatelessWidget {
  final TodayText todayText;
  final bool showSearch;
  const Header({Key? key, required this.todayText, this.showSearch = false})
      : super(key: key);
  // final todayText = const TodayText();
  // final expanded = Expanded(child: SearchField());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        this.todayText,
        SizedBox(width: kSpacing),
        showSearch ? Expanded(child: SearchField()) : Container(),
      ],
    );
  }
}
