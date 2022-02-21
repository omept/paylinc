part of app_helpers;

extension DynamicHelper on String {
  int? toInt() {
    return _toInt(this);
  }
}

int _toInt(dynamic val) {
  try {
    return int.parse(val.toString());
  } catch (_) {
    return 0;
  }
}
