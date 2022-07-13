import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/requirement.dart';

class RequirementService {
  List<requirement> reqFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<requirement>.from(
        data.map((item) => requirement.fromJson(item)));
  }

  List<requirement> reqFromJson2(String jsonString) {
    final data = json.decode(jsonString);
    return List<requirement>.from(
        data.map((item) => requirement.fromJson2(item)));
  }

  Future<List<requirement>> getData() async {
    try {
      final response =
          await http.get("http://192.168.190.1/Corporation/api/read_req.php");

      if (response.statusCode == 200) {
        List<requirement> list = reqFromJson(response.body);
        return list;
      } else {
        return List<requirement>();
      }
    } catch (e) {
      return List<requirement>();
    }
  }

  Future<List<requirement>> getReqEmp(String id) async {
    try {
      var map = Map<String, dynamic>();
      map["ID"] = id;
      final response = await http
          .post("http://192.168.190.1/Corporation/api/reademsk.php", body: map);

      if (response.statusCode == 200) {
        List<requirement> list = reqFromJson2(response.body);
        return list;
      } else {
        return List<requirement>();
      }
    } catch (e) {
      return List<requirement>();
    }
  }

  Future<List<requirement>> getReqtask(String id) async {
    try {
      var map = Map<String, dynamic>();
      map["ID"] = id;
      final response = await http.post(
          "http://192.168.190.1/Corporation/api/readsureq.php",
          body: map);

      if (response.statusCode == 200) {
        List<requirement> list = reqFromJson2(response.body);
        return list;
      } else {
        return List<requirement>();
      }
    } catch (e) {
      return List<requirement>();
    }
  }

  Future<String> addRequirement(requirement req) async {
    try {
      final response = await http.post(
          "http://192.168.190.1/Corporation/api/create_req.php",
          body: req.toJasonAdd());
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
