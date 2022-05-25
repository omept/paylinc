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
