part of app_helpers;

extension DynamicHelper on String {
  int toInt() {
    return _toInt(this);
  }

  double toDouble() {
    return _toDouble(this);
  }
}

int _toInt(dynamic val) {
  try {
    return int.parse(val.toString());
  } catch (_) {
    return 0;
  }
}

double _toDouble(dynamic val) {
  try {
    return double.parse(val.toString());
  } catch (_) {
    return 0;
  }
}
