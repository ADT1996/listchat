import 'package:flutter/material.dart';
import 'package:listchat/src/Navigator/Navigation.dart';
import 'package:listchat/src/Navigator/StringScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState(); 
}

class MyAppState extends State<MyApp> {

  MyAppState() : super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: initRoute(),
      initialRoute: SIGNINSCREEN,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        platform: TargetPlatform.iOS,
      ),
    );
  }

}