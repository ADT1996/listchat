import 'package:flutter/widgets.dart';

import 'package:listchat/src/Navigator/StringScreen.dart';
import 'package:listchat/src/screen/Room/main.dart';
import 'package:listchat/src/screen/Signin/main.dart';
import 'package:listchat/src/screen/Registry/main.dart';
import 'package:listchat/src/screen/Home/main.dart';

Map<String, Widget Function(BuildContext)> initRoute() => <String, Widget Function(BuildContext)> {
  SIGNINSCREEN: (BuildContext context) => Signin(),
  REGISTRYSCREEN: (BuildContext context) => Registry(),
  HOMESCREEN: (BuildContext context) => Home(),
  ROOMCHAT: (BuildContext context) => RoomChat()
};