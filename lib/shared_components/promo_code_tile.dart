import 'package:flutter/material.dart';
import 'package:paylinc/constants/app_constants.dart';

class PromoCodeTile extends StatelessWidget {
  const PromoCodeTile({Key? key, required this.code, this.fontSize = 10})
      : super(key: key);
  final String code;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: kNotifColor,
        // borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.center,
      child: Builder(builder: (context) {
        return Text(
          code,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        );
      }),
    );
  }
}
