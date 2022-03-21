part of app_helpers;

String dateTimeDisplay(String time) {
  try {
    return Jiffy(time).fromNow().toString();
  } catch (e) {
    return "";
  }
}
