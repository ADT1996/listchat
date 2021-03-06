import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:listchat/src/Common/enum.dart';

import 'package:listchat/src/Components/Component.dart';
import 'package:listchat/src/Model/Models.dart';
import 'package:listchat/src/screen/Home/dialog.dart';

import './controller.dart';
import './string.dart' as STRING;

class Home extends StatefulWidget {
  Home() : super();

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Controller _controller;

  DropdownButton<int> dropdownButton;

  HomeState() : super() {
    _controller = Controller(this);
  }

  @override
  void initState() {
    super.initState();
  }

  void showPopup() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => AlertDialog(
              title: Center(
                child: Text(STRING.ADDROOM),
              ),
              content: FormCreateRoom(
                onCompleted: (dynamic room) {
                  _controller.createRoom(room, context);
                },
                onCancel: () {
                  Navigator.of(context).pop();
                },
              ),
            ));
  }

  List<Widget> _getRooms(List<Room> rooms) => rooms.map((room) {
        bool isPublic = room.getMode() == RoomMode.PUBLIC;
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: OutlineButton(
            onPressed: _controller.getActionTap(room.getId()),
            borderSide: BorderSide(
              color: isPublic ? Colors.grey[500] : Colors.black,
              width: isPublic ? 0.5 : 1,
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
                  Text(
                    room.getRoomName(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    room.getBossName(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    room.getMembers().length.toString() + STRING.PEOPLE,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList();

  @override
  Widget build(BuildContext context) {
    _controller.initScreen();
    return ThemeApp(
      isLoading: _controller.isLoading,
      isShowingBottomBar: true,
      isScroll: false,
      title: Row(
        children: <Widget>[
          Flexible(
            child: CupertinoTextField(
              placeholder: STRING.ROOMNAME,
              dragStartBehavior: DragStartBehavior.down,
              onChanged: _controller.searchRoom,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              suffix: IconButton(
                icon: Icon(Icons.search, color: Theme.of(context).buttonColor),
                onPressed: _controller.searchRoomButton,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        PopupMenuButton(
            tooltip: STRING.SHOWMENU,
            elevation: 3.2,
            icon: Icon(Icons.menu),
            onSelected: _controller.onTapMenu,
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<String>>[
                PopupMenuItem(
                  value: STRING.ADDROOM,
                  child: Text(STRING.ADDROOM),
                ),
                PopupMenuItem(
                  value: STRING.JOINEDONLY,
                  child: _controller.showAll
                      ? Text(STRING.SHOWALL)
                      : Text(STRING.JOINEDONLY),
                )
              ];
            })
      ],
      child: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: _getRooms(_controller.viewRooms),
        ),
      ),
    );
  }
}
