import 'package:flutter/material.dart';
import 'package:new_app/models/employee.dart';
import 'package:new_app/models/subtask.dart';
import 'package:new_app/models/task.dart';
import 'package:intl/intl.dart';
import 'package:new_app/services/noti_serv.dart';
import 'package:new_app/services/subtask_serv.dart';
import 'package:new_app/services/task_serv.dart';
import 'package:new_app/widgets/choose_emplyees_forsubtasks.dart';
import 'package:new_app/widgets/subtask_assigne.dart';
import 'package:new_app/widgets/subtask_monitor.dart';
import 'package:toast/toast.dart';
import '../dummy_data.dart';
import '../models/employee.dart';

class SubtasksDetails extends StatefulWidget {
  static const routeName = '/SubtasksDetails';

  @override
  _SubtasksDetailsState createState() => _SubtasksDetailsState();
}

class _SubtasksDetailsState extends State<SubtasksDetails> {
  String taskid;
  List<SubTask> subtasks;
  bool loading = false;
  String taskstatus;
  assigne(String idtask, String idemp) async {
    String s = await SubTaskServ().assigne(idtask, idemp);
    print(s);
  }

  updateSubtaskStatus(String idsubtask, String status) async {
    String s = await SubTaskServ().updateStatus(idsubtask, status);
    print(s);
  }

  updatetaskStatus(String idtask, String status) async {
    String s = await TaskServ().updateStatus(idtask, status);
    print(s);
  }

  getSubtask() async {
    subtasks = await SubTaskServ().getData(taskid);
  }

  addnot(String receiver, String sender, String type, String idtask,
      String desc) async {
    String s =
        await NotifcationServ().addNoti(receiver, sender, type, idtask, desc);
    print(s);
  }

  assign(List<Employee> emps, String subtaskid, BuildContext context) async {
    for (var i = 0; i < emps.length; i++) {
      await assigne(subtaskid, emps[i].id);
      await addnot(
          emps[i].id, "1", "Assigne", subtaskid, "do u accept this subtask ?");
    }
    await updateSubtaskStatus(subtaskid, "Active");
    await updatetaskStatus(taskid, "Active");
    await getSubtask();
    Toast.show("requests to the employees have been sent", context,
        duration: 2, gravity: Toast.BOTTOM);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    String requesting_entity = data['requesting_entity'];
    String tasktype_name = data['tasktype_name'];
    subtasks = data['subtasks'];
    taskid = data['ID'];
    print(taskid);
    taskstatus = data['status'];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '$tasktype_name \n $requesting_entity',
            overflow: TextOverflow.fade,
          ),
        ),
        body: loading
            ? CircularProgressIndicator()
            : ListView.builder(
                itemBuilder: (context, index) {
                  if (subtasks[index].done == "NotAssigned") {
                    return SubTaskAssigne(subtasks[index], assign);
                  } else {
                    return SubTaskMonitor(subtasks[index]);
                  }
                },
                itemCount: subtasks.length,
              ));
  }
}
