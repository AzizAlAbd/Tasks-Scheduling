import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:new_app/models/requirement.dart';

class SubTask {
  final String id;
  final String name;
  String task_id;
  final DateTime start_date;
  final DateTime end_date;
  final String description;
  List<requirement> requirements = [];
  final String done;

  SubTask(
      {this.id,
      this.name,
      this.task_id,
      this.start_date,
      this.end_date,
      this.description,
      this.requirements,
      this.done});
  factory SubTask.fromJson(Map<String, dynamic> json) {
    return SubTask(
        id: json["ID"] as String,
        name: json["TName"] as String,
        start_date: DateTime.parse(json["Start"]),
        end_date: DateTime.parse(json["End"]),
        description: json["Description"] as String,
        done: json["Success"]);
  }
  factory SubTask.fromJson2(Map<String, dynamic> json) {
    return SubTask(
      id: json["ID"] as String,
      name: json["TName"] as String,
      start_date: DateTime.parse(json["Startdate"] as String),
      end_date: DateTime.parse(json["Enddate"] as String),
      description: json["Description"] as String,
      done: json["status"] as String,
    );
  }
  Map<String, dynamic> toJsonAdd() {
    return {
      "TID": task_id,
      "Name": name,
      "Start_Date": splitDate(start_date),
      "End_Date": splitDate(end_date),
      "PhoneDescription": description
    };
  }

  String splitDate(DateTime date) {
    String datestr = DateFormat.yMd().format(date).toString();
    List<String> s = datestr.split("/");
    print(s);
    for (var i = 0; i < s.length; i++) {
      if (s[i].length == 1) {
        s[i] = "0${s[i]}";
      }
    }
    return "${s[2]}-${s[0]}-${s[1]}";
  }
}
