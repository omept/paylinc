part of app_helpers;

bool canBeInteger(String value) {
  try {
    int.parse(value.replaceAll(",", ""));
    return true;
  } catch (e) {
    return false;
  }
}

bool canBeDouble(String value) {
  try {
    double.parse(value.replaceAll(",", ""));
    return true;
  } catch (e) {
    return false;
  }
}
