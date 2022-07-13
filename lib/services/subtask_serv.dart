import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_app/models/employee.dart';
import '../models/subtask.dart';

class SubTaskServ {
  Future<String> addsubtask(SubTask st) async {
    try {
      final response = await http.post(
          "http://192.168.190.1/Corporation/api/create_subtask.php",
          body: st.toJsonAdd());
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

  Future<String> getID(String name) async {
    try {
      var map = Map<String, dynamic>();
      map["Name"] = name;
      final response = await http.post(
          "http://192.168.190.1/Corporation/api/getSubTask_ID.php",
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

  Future<String> addReqtoTask(String idtask, String idReq) async {
    try {
      var map = Map<String, dynamic>();
      map["TID"] = idtask;
      map["RID"] = idReq;
      final response = await http.post(
          "http://192.168.190.1/Corporation/api/create_taskreq.php",
          body: map);
      if (response.statusCode == 200) {
        return response.body;
      } else
        return "error";
    } catch (e) {
      return "error";
    }
  }

  List<SubTask> reqFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<SubTask>.from(data.map((item) => SubTask.fromJson2(item)));
  }

  Future<List<SubTask>> getData(String id) async {
    try {
      var map = Map<String, dynamic>();
      map["ID"] = id;
      final response = await http
          .post("http://192.168.190.1/Corporation/api/readsuta.php", body: map);

      if (response.statusCode == 200) {
        List<SubTask> list = reqFromJson(response.body);

        return list;
      } else {
        return List<SubTask>();
      }
    } catch (e) {
      return List<SubTask>();
    }
  }

  Future<String> assigne(String idtask, idemp) async {
    try {
      var map = Map<String, dynamic>();
      map["EID"] = idemp;
      map["TID"] = idtask;
      final respone = await http.post(
          "http://192.168.190.1/Corporation/api/create_mission.php",
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

  List<Employee> employeeFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<Employee>.from(data.map((item) => Employee.fromJson2(item)));
  }

  Future<List<Employee>> getEmpforsubtasks(String id) async {
    try {
      var map = Map<String, dynamic>();
      map["ID"] = id;
      final respone = await http
          .post("http://192.168.190.1/Corporation/api/readtaem.php", body: map);
      if (respone.statusCode == 200) {
        List<Employee> list = employeeFromJson(respone.body);

        return list;
      } else {
        return List<Employee>();
      }
    } catch (e) {
      return List<Employee>();
    }
  }

  Future<String> updateStatus(String id, String status) async {
    try {
      var map = Map<String, dynamic>();
      map["ID"] = id;
      map["status"] = status;
      final respone = await http.post(
          "http://192.168.190.1/Corporation/api/update_subtask.php",
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

  Future<String> updateMission(
      String success, String date, String eID, String tID) async {
    try {
      var map = Map<String, dynamic>();
      map["Success"] = success;
      map["Actual_End_Date"] = date;
      map["EID"] = eID;
      map["TID"] = tID;
      final respone = await http.post(
          "http://192.168.190.1/Corporation/api/update_mission.php",
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
