import 'package:flutter/material.dart';
import 'package:listchat/src/Common/Common.dart';

import 'package:listchat/src/Components/Component.dart';
import 'package:listchat/src/Model/Models.dart';

import './controller.dart';
import './string.dart' as STRING;

class Home extends StatefulWidget {
  
  Home() : super();

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  Controller _controller;

  HomeState() : super() {
    _controller = Controller(this);
  }

  List<Widget> _getRooms(List<Room> rooms) => rooms.map((room) =>
    Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: OutlineButton(
        onPressed: _controller.getActionTap(room.getId()),
        borderSide: BorderSide(
          color: Colors.grey[300],
          width: 0.5,
          style: BorderStyle.solid,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        highlightedBorderColor: Colors.grey[300],
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(room.getRoomName(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),  
              ),
              Text(room.getBossName(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              Text(room.getMembers().length.toString() + STRING.PEOPLE,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    )
  ).toList();

  @override
  Widget build(BuildContext context) {

    _controller.initScreen();

    return ThemeApp(
      title: Text(Common.user.getFirstName()),
      isShowingBottomBar: true,
      isScroll: false,
      child: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: _getRooms(_controller.rooms),
        ),
      ),
    );
  }

}