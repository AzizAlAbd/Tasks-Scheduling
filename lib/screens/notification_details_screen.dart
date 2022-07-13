import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_app/services/noti_serv.dart';
import 'package:new_app/services/subtask_serv.dart';
import '../models/noification.dart';

class NotifiactionDetailsScreen extends StatefulWidget {
  static const routeName = "/NotificationDetailsScreen";
  @override
  _NotifiactionDetailsScreenState createState() =>
      _NotifiactionDetailsScreenState();
}

class _NotifiactionDetailsScreenState extends State<NotifiactionDetailsScreen> {
  MyNotification not;
  String title;

  addnot(String receiver, String sender, String type, String idtask,
      String desc) async {
    String s =
        await NotifcationServ().addNoti(receiver, sender, type, idtask, desc);
    print(s);
  }

  refuse() async {
    await addnot(not.sender, "1", "Reject", not.subtaskid,
        "you didnt complete your subtask please make sure your work is done ");
    Navigator.of(context).pop(not.id);
  }

  approve() async {
    await addnot(not.sender, "1", "Accept", not.subtaskid,
        "you have completed your subtask good job ! ");
    await SubTaskServ().updateMission(
        "1", splitDate(DateTime.now()), not.sender, not.subtaskid);
    Navigator.of(context).pop(not.id);
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

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    not = data["not"];
    title = data["title"];
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Details"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(not.id)),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Employee Name : ${not.sendername}",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    "SubTask Name : ${not.subtaskname}",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    "SubTask Start Date : ${not.taskstartdate}",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    "SubTask End Date : ${not.taskenddate}",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    "Notification Description : ${not.description}",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    "Task Description : ${not.subtaskdescription}",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            not.type == "Finish"
                ? Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: Colors.white,
                          onPressed: refuse,
                          child: Text(
                            "Refuse",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Colors.white,
                          onPressed: () {
                            approve();
                          },
                          child: Text(
                            "Approve",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
