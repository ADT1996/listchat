import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            child: Text(message.message,
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
          Text(_controller.room.getMembers().singleWhere((user) => user.getId() == message.memberId).getFirstName()),
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
            child: Text(message.message,
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

  Widget _buildMessageBubble(Message message) {
    return message.memberId == Common.user.getId() ? _buildMyMessageBubble(message) : _buildOtherPeopleMessageBubble(message);
  }

  Widget _buildButtons() {
    return ButtonBar(
      mainAxisSize: MainAxisSize.max,
      alignment: MainAxisAlignment.start,
      children: <Widget>[
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
        IconButton(
          icon: Icon(Icons.mic),
          onPressed: () {},
          padding: EdgeInsets.all(0),
          color: Colors.blue,
          tooltip: STRING.AUDIO,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          iconSize: 30,
        ),
        IconButton(
          icon: Icon(Icons.video_library),
          onPressed: () {},
          padding: EdgeInsets.all(0),
          color: Colors.blue,
          tooltip: STRING.VIDEO,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          iconSize: 30,
        ),
      ],
    );
  }

  Widget _buildInputMessage() {
    // return Flexible(
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: CupertinoTextField(
                  enableInteractiveSelection: true,
                  minLines: 1,
                  maxLines: 100,
                  placeholder: STRING.MESSAGE,
                  keyboardType: TextInputType.multiline,
                  dragStartBehavior: DragStartBehavior.down,
                  controller: TextEditingController(text: _controller.message),
                  onChanged: _controller.onChangedMessage,
                  onEditingComplete: _controller.onMessageCompleted,
                ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.send, color: Theme.of(context).buttonColor,),
                onPressed: _controller.sendMessage,
                tooltip: STRING.SEND,
              ),
            ),
          ],
      // )
    );
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            flex: 90,
            child: ListView(
              dragStartBehavior: DragStartBehavior.down,
              addAutomaticKeepAlives: true,
              children: <Widget>[..._controller.room.getMessages().map((message) => _buildMessageBubble(message))],
            ),
          ),
          Flexible(
            flex: 10,
            fit: FlexFit.tight,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Colors.grey[300]
                  )
                )
              ),
              child: Container(
                // mainAxisAlignment: MainAxisAlignment.start,
                // children: <Widget>[
                  // _buildButtons(),
                  child: _buildInputMessage(),
                // ],
              ),
            ),
          ),
        ],
      )
    );
  }
}