part of app_helpers;

int toInt(dynamic val) {
  try {
    return int.parse(val.toString());
  } catch (_) {
    return 0;
  }
}

double toDouble(dynamic val) {
  try {
    return double.parse(val.toString());
  } catch (_) {
    return 0;
  }
}

String reverseString(String input) {
  var chars = input.runes.toList();
  return String.fromCharCodes(chars.reversed);
}
