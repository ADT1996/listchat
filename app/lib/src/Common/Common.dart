import 'package:encrypt/encrypt.dart';

import 'package:listchat/src/Common/enum.dart';
import 'package:listchat/src/Model/Models.dart';
import 'package:listchat/src/Service/service.Common.dart';
import 'package:listchat/src/Config/config.dart' as config;

class Common {

  static dynamic user = null;

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
        video: message[Parameter.VIDEO],
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
        messages: room[Parameter.MESSAGES] == null ? null : objectToMessages(room[Parameter.MESSAGES]),
        mode: room[Parameter.MODEROOM] == 0 ? RoomMode.PUBLIC : RoomMode.PRIVATE
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
      messages: data[Parameter.MESSAGES] == null ? null : objectToMessages(data[Parameter.MESSAGES]),
      mode: data[Parameter.MODEROOM] == 0 ? RoomMode.PUBLIC : RoomMode.PRIVATE,
    );
  }

  static User objectToUser(dynamic data) {
    return User(
        id: data[Parameter.ID],
        email: data[Parameter.EMAIL],
        firstName: data[Parameter.FIRSTNAME],
        lastName: data[Parameter.LASTNAME],
        birthday: data[Parameter.BIRTHDAY] != null ? DateTime.parse(data[Parameter.BIRTHDAY]) : null,
        gender: data[Parameter.GENDER] as bool,
      );
  }

  static String encryptString(String string) {

    try {

      final String keyString = config.key.map((number) => String.fromCharCode(number)).join('');
      final String ivString = config.iv.map((number) => String.fromCharCode(number)).join('');

      final Key key = Key.fromUtf8(keyString);
      final IV iv = IV.fromUtf8(ivString);

      final Encrypter aes = Encrypter(AES(key, mode: AESMode.cbc));
      final Encrypted enscrypted = aes.encrypt(string, iv: iv);
      String enscyptedString = enscrypted.base16;
      return enscyptedString;
    } catch(err) {
      throw err;
    }
  }
}