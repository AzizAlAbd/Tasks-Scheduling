import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_app/widgets/add_suptask.dart';
import '../models/task.dart';
import '../models/subtask.dart';

class TaskServ {
  Future<String> addTask(Task t) async {
    try {
      final response = await http.post(
          "http://192.168.190.1/Corporation/api/create_task.php",
          body: t.toJasonAdd());
      if (response.statusCode == 200) {
        print("Add response " + response.body);
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  Future<String> getID(String requestEntity, String tasktypeID) async {
    try {
      var map = Map<String, dynamic>();
      map["Requesting_Party"] = requestEntity;
      map["Type_ID"] = tasktypeID;
      final response = await http.post(
          "http://192.168.190.1/Corporation/api/getTask_ID.php",
          body: map);
      if (response.statusCode == 200) {
        print(response.body);
        final data = json.decode(response.body);
        return data["ID"] as String;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  List<Task> reqFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<Task>.from(data.map((item) => Task.fromJson(item)));
  }

  Future<List<Task>> getData() async {
    try {
      final response =
          await http.get("http://192.168.190.1/Corporation/api/read_task.php");

      if (response.statusCode == 200) {
        List<Task> list = reqFromJson(response.body);

        return list;
      } else {
        return List<Task>();
      }
    } catch (e) {
      return List<Task>();
    }
  }

  Future<String> updateStatus(String id, String status) async {
    try {
      var map = Map<String, dynamic>();
      map["ID"] = id;
      map["status"] = status;
      final respone = await http.post(
          "http://192.168.190.1/Corporation/api/update_task.php",
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
}
