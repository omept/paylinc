import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayText extends StatelessWidget {
  const TodayText({Key? key, required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.message,
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            DateFormat.yMMMEd().format(DateTime.now()),
          )
        ],
      ),
    );
  }
}
