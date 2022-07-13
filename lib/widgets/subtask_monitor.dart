import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_app/models/employee.dart';
import 'package:new_app/models/requirement.dart';
import 'package:new_app/models/subtask.dart';
import 'package:new_app/services/subtask_serv.dart';
import '../models/subtask.dart';
import '../widgets/choose_emplyees_forsubtasks.dart';
import '../services/req_serv.dart';

class SubTaskMonitor extends StatefulWidget {
  final SubTask subtask;
  SubTaskMonitor(this.subtask);

  @override
  _SubTaskMonitorState createState() => _SubTaskMonitorState();
}

class _SubTaskMonitorState extends State<SubTaskMonitor> {
  List<requirement> reqs = [];
  List<Employee> emps = [];
  bool loading = true;
  bool loading2 = true;
  getReq() async {
    reqs = await RequirementService().getReqtask(widget.subtask.id);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReq();
    getEmps(widget.subtask.id);
  }

  getEmps(String id) async {
    emps = await SubTaskServ().getEmpforsubtasks(id);

    setState(() {
      loading2 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    getEmps(widget.subtask.id);
    Color color;
    switch (widget.subtask.done) {
      case "Active":
        {
          color = Colors.greenAccent[700];

          break;
        }
      case "Finished":
        {
          color = Colors.blueAccent;

          break;
        }
      case "Outofdeadline":
        {
          color = Colors.red;

          break;
        }
      default:
    }
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).accentColor,
                offset: Offset.zero,
                blurRadius: 6,
                spreadRadius: 2)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.subtask.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Theme.of(context).accentColor),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                      ' ${DateFormat.yMMMd().format(widget.subtask.start_date).toString()}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).accentColor),
                    ),
                    Icon(Icons.arrow_forward),
                    Text(
                      ' ${DateFormat.yMMMd().format(widget.subtask.end_date).toString()}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).accentColor),
                    ),
                  ]),
                  Divider(
                    thickness: 2,
                  ),
                  Text(
                    '${widget.subtask.description}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).accentColor),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  loading
                      ? CircularProgressIndicator()
                      : Wrap(
                          direction: Axis.horizontal,
                          runSpacing: 4,
                          spacing: 4,
                          children: [
                            ...reqs.map((req) {
                              return Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).accentColor),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  req.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Theme.of(context).accentColor),
                                ),
                              );
                            }).toList()
                          ],
                        ),
                  SizedBox(
                    height: 5,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              title: Text(
                                "Employees",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context).accentColor,
                                          width: 3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  child: loading2
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              ...emps.map((emp) {
                                                //getReqEmp(emp.id);
                                                bool b;
                                                String i;
                                                if (emp.success == "0")
                                                  i = "Working";
                                                else if (emp.success == "1")
                                                  i = "Done";
                                                else
                                                  i = "Wating";
                                                return ListTile(
                                                  trailing: Text(
                                                    i,
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                  title: Text(
                                                    emp.name,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                );
                                              }).toList()
                                            ],
                                          ),
                                        ),
                                ),
                                Center(
                                  child: RaisedButton(
                                    child: Text(
                                      'cancel',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    color: Theme.of(context).accentColor,
                                  ),
                                )
                              ],
                            );
                          });
                    },
                    child: Text("Employees on this subtask"),
                  )
                ],
              ),
            ),
          ),
          Container(
              width: 20,
              height: 235,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ))
        ],
      ),
    );
  }
}
