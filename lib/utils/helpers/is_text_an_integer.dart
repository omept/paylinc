bool canBeInteger(String value) {
  try {
    int.parse(value);
    return true;
  } catch (e) {
    return false;
  }
}
