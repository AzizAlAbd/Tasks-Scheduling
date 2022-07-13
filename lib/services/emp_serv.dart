import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/employee.dart';

import '../models/subtask.dart';

class EmployeeService {
  List<Employee> employeeFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<Employee>.from(data.map((item) => Employee.fromJson(item)));
  }

  Future<List<Employee>> getData() async {
    try {
      final response = await http
          .post("http://192.168.190.1/Corporation/api/read_employee.php");

      if (response.statusCode == 200) {
        List<Employee> list = employeeFromJson(response.body);
        return list;
      } else {
        return List<Employee>();
      }
    } catch (e) {
      return List<Employee>();
    }
  }

  Future<String> getID(String name) async {
    try {
      var map = Map<String, dynamic>();
      map['Name'] = name;
      final response = await http.post(
          "http://192.168.190.1/Corporation/api/getEmp_ID.php",
          body: map);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return data["ID"] as String;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  Future<String> addEmpolyee(Employee emp) async {
    try {
      final response = await http.post(
          "http://192.168.190.1/Corporation/api/create_employee.php",
          body: emp.toJasonAdd());
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

  Future<String> addReqtoEmp(String idEmp, String idReq) async {
    try {
      var map = Map<String, dynamic>();
      map["EID"] = idEmp;
      map["RID"] = idReq;
      final response = await http.post(
          "http://192.168.190.1/Corporation/api/create_skills.php",
          body: map);
      if (response.statusCode == 200) {
        return response.body;
      } else
        return "error";
    } catch (e) {
      return "error";
    }
  }

  Future<String> deleteEmployee(String id) async {
    try {
      var map = Map<String, dynamic>();
      map['ID'] = id;
      final response = await http.post(
          "http://192.168.190.1/Corporation/api/delete_employee.php",
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

  List<SubTask> subtaskFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<SubTask>.from(
        data["data"].map((item) => SubTask.fromJson(item)));
  }

  Future<List<SubTask>> getSubtaskEmp(String id) async {
    try {
      var map = Map<String, dynamic>();
      map["ID"] = id;
      final response = await http
          .post("http://192.168.190.1/Corporation/api/reademta.php", body: map);
      if (response.statusCode == 200) {
        List<SubTask> list = subtaskFromJson(response.body);
        return list;
      } else {
        print("e");
        return List<SubTask>();
      }
    } catch (e) {
      return List<SubTask>();
    }
  }
}
