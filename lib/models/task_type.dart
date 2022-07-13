import 'package:flutter/foundation.dart';

class TaskType {
  final String name_of_task;
  final String id;
  final String description;
  final String accomplishment_time;

  TaskType(
      {this.id, this.name_of_task, this.description, this.accomplishment_time});

  factory TaskType.fromJson(Map<String, dynamic> json) {
    return TaskType(
        id: json["ID"] as String,
        name_of_task: json["Name"] as String,
        description: json["Description"] as String,
        accomplishment_time: json["Duration"] as String);
  }
  Map<String, dynamic> toJasonAdd() {
    return {
      "Name": name_of_task,
      "Description": description,
      "Duration": accomplishment_time
    };
  }
}
