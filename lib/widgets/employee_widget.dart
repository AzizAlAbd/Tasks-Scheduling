import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:new_app/dummy_data.dart';
import 'package:new_app/models/employee.dart';
import 'package:new_app/screens/employee_tasks_screen.dart';

class EmployeeWidget extends StatelessWidget {
  final Employee emp;
  final Function deleteEmp;
  EmployeeWidget(this.emp, this.deleteEmp);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shadowColor: Theme.of(context).accentColor,
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ListTile(
          onTap: () {
            Navigator.of(context)
                .pushNamed(EmployeeTasks.routeName, arguments: emp);
          },
          leading: CircleAvatar(
            child: Text(emp.name.substring(0, 1)),
          ),
          title: Text(
            emp.name,
            style: TextStyle(fontSize: 18),
          ),
          /*subtitle: Text("Number of tasks : ${emp.subtasks.length}"),*/
          trailing: IconButton(
              icon: Icon(
                Icons.delete,
                size: 30,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Delete Employee'),
                      content: Container(
                        height: 100,
                        child: Column(
                          children: [
                            Text(
                              'Are you sure you want to delete this emoloyee',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: Colors.purple, fontSize: 18),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    deleteEmp(emp.id);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Ok',
                                    style: TextStyle(
                                        color: Colors.purple, fontSize: 18),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
