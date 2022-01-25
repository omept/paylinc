part of 'app_helpers.dart';

class B64Encoder {
  static String base64Encode(String credentials) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(credentials);
  }

  static String base64Decode(String credentials) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.decode(credentials);
  }

  static String base64UrlEncode(String credentials) {
    Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);
    return stringToBase64Url.encode(credentials);
  }

  static String base64UrlDecode(String credentials) {
    Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);
    return stringToBase64Url.decode(credentials);
  }
}
