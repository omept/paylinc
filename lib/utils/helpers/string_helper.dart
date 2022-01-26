part of app_helpers;

extension DynamicHelper on String {
  int? toInt() {
    _toInt(this);
  }
}

int? _toInt(dynamic val) {
  try {
    return int.parse(val.toString());
  } catch (_) {
    return null;
  }
}
