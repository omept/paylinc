part of app_helpers;

bool canBeInteger(String value) {
  try {
    int.parse(value);
    return true;
  } catch (e) {
    return false;
  }
}

bool canBeDouble(String value) {
  try {
    double.parse(value);
    return true;
  } catch (e) {
    return false;
  }
}
