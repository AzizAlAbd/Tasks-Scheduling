import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_type.dart';

class TaskTypeServ {
  List<TaskType> reqFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<TaskType>.from(data.map((item) => TaskType.fromJson(item)));
  }

  Future<List<TaskType>> getAllTaskType() async {
    try {
      print("hey");
      final response = await http
          .get("http://192.168.190.1/Corporation/api/read_taskty.php");

      if (response.statusCode == 200) {
        List<TaskType> list = reqFromJson(response.body);
        return list;
      } else {
        return List<TaskType>();
      }
    } catch (e) {
      return List<TaskType>();
    }
  }

  Future<String> addTaskType(TaskType type) async {
    try {
      final response = await http.post(
          "http://192.168.190.1/Corporation/api/create_taskty.php",
          body: type.toJasonAdd());
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
}
