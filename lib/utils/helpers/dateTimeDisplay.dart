import 'package:jiffy/jiffy.dart';

String dateTimeDisplay(String time) {
  try {
    return Jiffy('$time').fromNow().toString();
  } catch (e) {
    return "";
  }
}
