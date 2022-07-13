import 'package:intl/intl.dart';
import 'package:new_app/models/subtask.dart';
import 'package:new_app/models/task_type.dart';

class Task {
  final String id;
  final String requesting_entity;
  final String task_type;
  String task_type_name;
  String task_type_duration;
  final DateTime begin_date;
  final List<SubTask> subtasks;
  String status;
  static List<Task> tasks;
  Task(
      {this.id,
      this.requesting_entity,
      this.task_type,
      this.task_type_name,
      this.task_type_duration,
      this.begin_date,
      this.subtasks,
      this.status});

  Map<String, dynamic> toJasonAdd() {
    return {
      'Type_ID': task_type,
      'Requesting_Party': requesting_entity,
      'Start_Date': splitDate(DateFormat.yMd().format(begin_date).toString())
    };
  }

  String splitDate(String date) {
    List<String> s = date.split("/");
    print(s);
    for (var i = 0; i < s.length; i++) {
      if (s[i].length == 1) {
        s[i] = "0${s[i]}";
      }
    }
    return "${s[2]}-${s[0]}-${s[1]}";
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["ID"] as String,
      task_type_name: json["TName"] as String,
      task_type_duration: json["Duration"] as String,
      requesting_entity: json["Requesting_Party"] as String,
      begin_date: DateTime.parse(json["Start_Date"]),
      status: json["status"] as String,
    );
  }
}
