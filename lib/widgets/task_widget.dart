import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_app/models/subtask.dart';
import 'package:new_app/screens/subtasks_for_thetask_screen.dart';
import 'package:new_app/services/subtask_serv.dart';
import 'package:new_app/services/task_serv.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

class TaskWidget extends StatefulWidget {
  final Task task;

  TaskWidget(this.task);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  List<SubTask> subtasks;

  bool loading = true;
  int notassingedcount = 0;
  int assignedcount = 0;
  getSubtask() async {
    subtasks = await SubTaskServ().getData(widget.task.id);
    notassingedcount = 0;
    assignedcount = 0;
    for (var i = 0; i < subtasks.length; i++) {
      if (subtasks[i].done == 'NotAssigned') {
        notassingedcount++;
      } else {
        assignedcount++;
      }
    }
    for (var i = 0; i < subtasks.length; i++) {
      if (subtasks[i].end_date.isBefore(DateTime.now()) &&
          (subtasks[i].done != "Outofdeadline" &&
              subtasks[i].done != "NotAssigned")) {
        updateStatus(subtasks[i].id, "Outofdeadline");
        updatetaskStatus(widget.task.id, "Outofdeadline");
      }
    }
    setState(() {
      loading = false;
    });
  }

  updateStatus(String idsubtask, String status) async {
    String s = await SubTaskServ().updateStatus(idsubtask, status);
    print(s);
  }

  updatetaskStatus(String idtask, String status) async {
    String s = await TaskServ().updateStatus(idtask, status);
    print(s);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSubtask();
  }

  @override
  Widget build(BuildContext context) {
    getSubtask();
    Color color;
    IconData icon;
    switch (widget.task.status) {
      case "NotAssigned":
        {
          color = Colors.grey;
          icon = Icons.sentiment_neutral;
          break;
        }
      case "Active":
        {
          color = Colors.greenAccent[700];
          icon = Icons.sentiment_satisfied;
          break;
        }
      case "Finished":
        {
          color = Colors.blueAccent;
          icon = Icons.sentiment_very_satisfied;
          break;
        }
      case "Outofdeadline":
        {
          color = Colors.red;
          icon = Icons.sentiment_very_dissatisfied;
          break;
        }
      default:
    }
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      padding: EdgeInsets.only(
        left: 10,
      ),
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(SubtasksDetails.routeName, arguments: {
            'subtasks': subtasks,
            'requesting_entity': widget.task.requesting_entity,
            'tasktype_name': widget.task.task_type_name,
            'ID': widget.task.id,
            'status': widget.task.status,
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.task_type_name,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: Colors.black54,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Text(
                      '${widget.task.requesting_entity} ',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Begin Date :  ${DateFormat.yMMMd().format(widget.task.begin_date).toString()} ',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: Colors.black54,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.task.task_type_duration} Days ',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.7),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          icon,
                          color: color,
                          size: 70,
                        ),
                        loading
                            ? CircularProgressIndicator()
                            : Column(
                                children: [
                                  Text(
                                    'Subtasks : ${subtasks.length}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.7),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Assigned : $assignedcount',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.7),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Not Assigned : $notassingedcount',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.7),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 7,
            ),
            Container(
              width: 20,
              height: 196,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
