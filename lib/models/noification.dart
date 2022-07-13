import 'package:flutter/foundation.dart';

class MyNotification {
  final String id;
  final String subtaskid;
  final String taskid;
  final String subtaskname;
  final String receiver;
  final String recivername;
  final String sender;
  final String sendername;
  final String description;
  final String subtaskdescription;
  final String type;
  final String taskstartdate;
  final String taskenddate;
  final String read;
  static List<MyNotification> n;
  MyNotification(
      {this.id,
      this.recivername,
      this.sendername,
      this.subtaskname,
      this.subtaskid,
      this.taskid,
      this.receiver,
      this.sender,
      this.description,
      this.subtaskdescription,
      this.type,
      this.taskenddate,
      this.taskstartdate,
      this.read});
  factory MyNotification.fromJson(Map<String, dynamic> json) {
    return MyNotification(
        id: json["NID"] as String,
        sender: json["SenderID"] as String,
        sendername: json["EName"] as String,
        subtaskid: json["SID"] as String,
        subtaskname: json["TName"] as String,
        taskid: json['TID'] as String,
        type: json["NotType"] as String,
        taskenddate: json["End"] as String,
        taskstartdate: json["Start"] as String,
        description: json["Description"] as String,
        subtaskdescription: json["SubtaskDesc"] as String,
        read: json['reead'] as String);
  }
}
