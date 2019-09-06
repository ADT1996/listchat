
import 'package:listchat/src/Config/config.dart';

class API {

  static const String BASE_URI = '$HOST';

  static String _token;

  static String getToken() => _token;
  static void setToken(String token) => _token = token;
}

class Header {
  static const String AUTHORIZATION = 'authorization';
  static const String CONTENT_TYPE = 'Content-Type';
  static const APP_JSON = 'application/json';
  static const APP_URLENCODED = 'application/x-www-form-urlencoded';
}