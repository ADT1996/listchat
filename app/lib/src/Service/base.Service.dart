import 'package:listchat/src/API/API.dart';

class Service {
  static String getToken() => API.getToken();
  static void setToken(String token) => API.setToken(token);
}
