import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/noification.dart';

class NotifcationServ {
  Future<String> addNoti(String receiver, String sender, String type,
      String idtask, String desc) async {
    try {
      var map = Map<String, dynamic>();
      map["TID"] = idtask;
      map["Receiver"] = receiver;
      map["Sender"] = sender;
      map["Description"] = desc;
      map["Type"] = type;
      final respone = await http.post(
          "http://192.168.190.1/Corporation/api/create_not.php",
          body: map);
      if (respone.statusCode == 200) {
        return respone.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  List<MyNotification> notFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<MyNotification>.from(
        data.map((item) => MyNotification.fromJson(item)));
  }

  Future<List<MyNotification>> getNotificationData(String id) async {
    try {
      var map = Map<String, dynamic>();
      map["ID"] = id;
      final response = await http
          .post("http://192.168.190.1/Corporation/api/readalot.php", body: map);
      if (response.statusCode == 200) {
        List<MyNotification> list = notFromJson(response.body);
        return list;
      } else {
        return List<MyNotification>();
      }
    } catch (e) {
      return List<MyNotification>();
    }
  }

  Future<String> updateRead(String id, String read) async {
    try {
      var map = Map<String, dynamic>();
      map["ID"] = id;
      map["Reead"] = read;
      final response = await http.post(
          "http://192.168.190.1/Corporation/api/update_not.php",
          body: map);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
