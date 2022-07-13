import 'package:flutter/material.dart';
import 'package:new_app/models/employee.dart';
import 'package:intl/intl.dart';
import 'package:new_app/models/subtask.dart';

import '../models/subtask.dart';
import '../services/emp_serv.dart';

class EmployeeTasks extends StatefulWidget {
  static const routeName = '/EmployeeTasks';

  @override
  _EmployeeTasksState createState() => _EmployeeTasksState();
}

class _EmployeeTasksState extends State<EmployeeTasks> {
  List<SubTask> subtasks = [];
  bool loading = true;
  getEmployeeSubtask(String id) async {
    subtasks = await EmployeeService().getSubtaskEmp(id);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Employee emp = ModalRoute.of(context).settings.arguments;
    getEmployeeSubtask(emp.id);
    return Scaffold(
        body: Container(
      color: Colors.purple[50],
      padding: EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop()),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 230,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  right: 0,
                  top: 25,
                  left: 0,
                  child: Container(
                    height: 160,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.only(top: 45, bottom: 20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Text(
                          emp.name,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          emp.email,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          emp.phoneNumber,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 40,
                    child: Text(
                      emp.name.substring(0, 1),
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 380,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Text(
                  "Subtasks",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Divider(
                  color: Colors.black,
                ),
                Container(
                    height: 320,
                    padding: EdgeInsets.only(top: 0),
                    child: loading
                        ? Center(child: CircularProgressIndicator())
                        : subtasks.isNotEmpty
                            ? ListView.builder(
                                itemBuilder: (context, index) {
                                  String status = subtasks[index].done == "1"
                                      ? 'Done'
                                      : 'Not completed yet';

                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    margin: EdgeInsets.only(
                                        bottom: 10, left: 20, right: 20),
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            subtasks[index].name,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          Divider(
                                            thickness: 2,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                DateFormat.yMMMd()
                                                    .format(subtasks[index]
                                                        .start_date)
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(Icons.arrow_forward),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                DateFormat.yMMMd()
                                                    .format(subtasks[index]
                                                        .end_date)
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            thickness: 2,
                                          ),
                                          Text(
                                            subtasks[index].description,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          Divider(
                                            thickness: 2,
                                          ),
                                          Text(
                                            'Status : $status',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: subtasks.length,
                              )
                            : Center(
                                child: Text(
                                  "No subtasks for this employee",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
