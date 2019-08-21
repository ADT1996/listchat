import 'package:listchat/src/Model/Models.dart';
import 'package:listchat/src/Service/service.Common.dart';

class Common {

  static User user = User(
    birthday: null,
    email: '',
    firstName: '',
    gender: false,
    id: '',
    lastName: '',
    token: ''
  );

  static List<User> objectToUsers(dynamic data) {
    List<dynamic> list = data.map((user) {
      return User(
        id: user[Parameter.ID],
        email: user[Parameter.EMAIL],
        firstName: user[Parameter.FIRSTNAME],
        lastName: user[Parameter.LASTNAME],
        birthday: DateTime.parse(user[Parameter.BIRTHDAY]),
        gender: user[Parameter.GENDER] as bool,
      );
    }).toList();
    return <User>[...list];
  }

  static List<Message> objectToMessages(dynamic data) {
    List<dynamic> list = data.map((message) {
      return Message(
        id: message[Parameter.ID],
        audio: message[Parameter.AUDIO],
        image: message[Parameter.IMAGE],
        memberId: message[Parameter.MEMBERID],
        message: message[Parameter.MESSAGE],
        video: message[Parameter.VIDEO]
      );
    }).toList();
    return <Message>[...list];
  }

  static List<Room> objectToRooms(dynamic data) {
    List<dynamic> list = data.map((room) {
      return Room(
        id: room[Parameter.ID],
        roomName: room[Parameter.ROOMNAME],
        bossId: room[Parameter.BOSSID],
        bossName: room[Parameter.BOSSNAME],
        members: room[Parameter.MEMBERS] == null ? null : objectToUsers(room[Parameter.MEMBERS]),
        messages: room[Parameter.MESSAGES] == null ? null : objectToMessages(room[Parameter.MESSAGES])
      );
    }).toList();
    return <Room>[...list];
  }

  static Room objectToRoom(dynamic data) {
    return Room(
      id: data[Parameter.ID],
      roomName: data[Parameter.ROOMNAME],
      bossId: data[Parameter.BOSSID],
      bossName: data[Parameter.BOSSNAME],
      members: objectToUsers(data[Parameter.MEMBERS]),
      messages: data[Parameter.MESSAGES] == null ? null : objectToMessages(data[Parameter.MESSAGES])
    );
  }
}