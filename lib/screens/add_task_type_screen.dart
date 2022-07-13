import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../models/task_type.dart';
import '../services/tasktype_serv.dart';

class AddTaskType extends StatefulWidget {
  static const routeName = '/AddTaskType';
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<AddTaskType> {
  final _key = GlobalKey<FormState>();
  //String valueChoose = 'Hour';
  final namecontroller = TextEditingController();
  final acctcontroller = TextEditingController();
  final descecontroller = TextEditingController();
  List<TaskType> tasktype;
  /*List<DropdownMenuItem> listitem = [
    DropdownMenuItem(
        child: Text(
          'Hour',
        ),
        value: 'Hour'),
    DropdownMenuItem(
        child: Text(
          'Day',
        ),
        value: 'Day'),
    DropdownMenuItem(
        child: Text(
          'Week',
        ),
        value: 'Week'),
    DropdownMenuItem(
        child: Text(
          'Month',
        ),
        value: 'Month'),
    DropdownMenuItem(
        child: Text(
          'Year',
        ),
        value: 'Year')
  ];*/
  Widget _buildContainer(Widget w) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).accentColor,
                  offset: Offset.zero,
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            color: Colors.white,
            border: Border.all(),
            borderRadius: BorderRadius.circular(12)),
        child: w);
  }

  bool isExist(String title, BuildContext ctx) {
    if (tasktype.isEmpty) {
      return false;
    }
    for (var i = 0; i < tasktype.length; i++) {
      if (tasktype[i].name_of_task == title) return true;
    }
    return false;
  }

  void sumbit(BuildContext ctx) {
    setState(() {
      String acctime = acctcontroller.text;
      String description = descecontroller.text;
      String name = namecontroller.text;
      if (acctime.isNotEmpty && name.isNotEmpty && description.isNotEmpty) {
        if (!isExist(name, ctx)) {
          print(isExist(name, ctx));
          TaskType t1 = new TaskType(
              name_of_task: namecontroller.text,
              description: descecontroller.text,
              accomplishment_time: acctime);
          addTaskType(t1);
          Toast.show("The task type has been added", context,
              gravity: Toast.BOTTOM, duration: 2);
          acctcontroller.clear();
          namecontroller.clear();
          descecontroller.clear();
        } else {
          Toast.show(
              "The task type is already in the system \n please ckeck the title",
              context,
              gravity: Toast.BOTTOM,
              duration: 2);
        }
      } else {
        return;
      }
    });
  }

  addTaskType(TaskType tt) async {
    String s = await TaskTypeServ().addTaskType(tt);
    print(s);
  }

  @override
  Widget build(BuildContext context) {
    tasktype = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Task Type',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildContainer(
                Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Type Tilte :',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          maxLength: 25,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 16),
                              hintText: "task type title "),
                          controller: namecontroller,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Required';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Text(
                          'Accomplishment Time (Days):',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 50,
                          height: 70,
                          alignment: Alignment.center,
                          child: TextFormField(
                              maxLength: 3,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(hintText: "NNN"),
                              keyboardType: TextInputType.number,
                              controller: acctcontroller,
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'Required';
                                else
                                  return null;
                              }),
                        ),

                        /*DropdownButton(
                            value: valueChoose,
                            items: listitem,
                            onChanged: (value) {
                              setState(() {
                                valueChoose = value;
                              });
                            })*/
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Description :',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                errorStyle: TextStyle(fontSize: 16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            controller: descecontroller,
                            maxLines: 4,
                            validator: (value) {
                              if (value.isEmpty)
                                return 'please fill this field';
                              else
                                return null;
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: RaisedButton(
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    if (!_key.currentState.validate()) {
                      return;
                    } else
                      sumbit(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Theme.of(context).accentColor,
                ),
              )
            ],
          ),
        ));
  }
}
