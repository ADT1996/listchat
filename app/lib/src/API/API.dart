
import 'package:listchat/src/Config/config.dart';

class API {

  static const String BASE_URI = 'http://$HOST';

  static String _token;

  static String getToken() => _token;
  static void setToken(String token) => _token = token;
}

class Header {
  static const String AUTHORIZATION = 'authorization';
}