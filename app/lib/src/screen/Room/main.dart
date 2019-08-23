import 'package:flutter/material.dart';
import 'package:listchat/src/Common/Common.dart';
import 'package:listchat/src/Components/Component.dart';
import 'package:listchat/src/Components/Layout.dart';
import 'package:listchat/src/Model/Message.dart';
import 'package:listchat/src/screen/Room/controller.dart';

import './string.dart' as STRING;

class RoomChat extends StatefulWidget {
  @override
  RoomchatState createState() => RoomchatState();
}

class RoomchatState extends State<RoomChat> {

  Controller _controller;

  RoomchatState() : super() {
    _controller = Controller(this);
  }

  Widget _buildMyMessageBubble(Message message) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: EdgeInsets.fromLTRB(width * 0.51, 5, 5, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(Common.user.getFirstName()),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.blue,
                width: 1
              ),
            ),
            child: Text(message.getMessage(),
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                textBaseline: TextBaseline.ideographic,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOtherPeopleMessageBubble(Message message) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: EdgeInsets.fromLTRB(5, 5, width * 0.51, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(_controller.room.getMembers().singleWhere((user) => user.getId() == message.getMemberId()).getFirstName()),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey[200],
                width: 1
              ),
            ),
            child: Text(message.getMessage(),
              softWrap: true,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, Message message) {
    return message.getMemberId() == Common.user.getId() ? _buildMyMessageBubble(message) : _buildOtherPeopleMessageBubble(message);
  }

  List<Widget> _buildButtons(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.image),
        onPressed: () {},
        padding: EdgeInsets.all(0),
        color: Colors.blue,
        tooltip: STRING.IMAGE,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        iconSize: 30,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {

    _controller.initScreen();

    return ThemeApp(
      isShowingBottomBar: false,
      isScroll: false,
      title: Text(_controller.room.getRoomName()),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            flex: 90,
            child: ListView(
              children: <Widget>[..._controller.room.getMessages().map((message) => _buildMessageBubble(context, message))],
            ),
          ),
          Flexible(
            flex: 10,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Colors.grey[300]
                  )
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ButtonBar(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      ..._buildButtons(context)
                    ],
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}