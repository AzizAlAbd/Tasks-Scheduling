import 'package:flutter/material.dart';
import 'package:new_app/models/task.dart';
import 'package:new_app/screens/add_task_type_screen.dart';
import 'package:new_app/services/subtask_serv.dart';
import 'package:new_app/widgets/add_suptask.dart';
import 'package:new_app/models/task_type.dart';
import 'package:intl/intl.dart';
import 'package:new_app/screens/subtask_screen.dart';
import 'package:new_app/widgets/drawer_widget.dart';
import 'package:toast/toast.dart';
import '../models/subtask.dart';
import '../widgets/badge.dart';
import '../services/tasktype_serv.dart';
import '../services/task_serv.dart';

class DefineProject extends StatefulWidget {
  static const routeName = '/DefineProject';
  @override
  _DefineProjectState createState() => _DefineProjectState();
}

class _DefineProjectState extends State<DefineProject> {
  final _key = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final requesting_entity = TextEditingController();
  DateTime date = null;
  String databaseDate;
  String valueChoose;
  List<SubTask> subtasks_list = [];
  bool loading = true;
  String idTask;
  String idSubTask;
  TaskType choosentasktype;
  List<TaskType> tasktype = [
    /*TaskType(DateTime.now().toString(), 'Create a DB', 'aa', '2D'),
    TaskType(DateTime.now().toString(), 'develop an app', 'aa', '2D'),
    TaskType(DateTime.now().toString(), 'develop a website', 'aa', '2D')*/
  ];

  List<DropdownMenuItem> listitem() {
    return tasktype.map((type) {
      return DropdownMenuItem(
        child: Text(
          type.name_of_task,
          overflow: TextOverflow.fade,
          style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
        ),
        value: type.name_of_task,
      );
    }).toList();
  }

  void _datepiker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2025))
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        date = value;
      });
    });
  }

  void _movetosubtaskscreen() {
    Navigator.of(context)
        .pushNamed(SubtaskScreen.routeName, arguments: subtasks_list)
        .then((value) => print(subtasks_list));
  }

  getTaskType() async {
    tasktype = await TaskTypeServ().getAllTaskType();
    valueChoose = tasktype[0].name_of_task;
    choosentasktype = tasktype[0];
    setState(() {
      loading = false;
    });
  }

  addTask(Task t) async {
    String s = await TaskServ().addTask(t);
    print(s);
  }

  getTaskID(String requesting_entity, String tasktype_id) async {
    idTask = await TaskServ().getID(requesting_entity, tasktype_id);
  }

  addsubtask(SubTask st) async {
    String s = await SubTaskServ().addsubtask(st);
    print(s);
  }

  getSubtaskID(String name) async {
    idSubTask = await SubTaskServ().getID(name);
    print(idSubTask);
  }

  addReqtoTask(String idtask, String idReq) async {
    String s = await SubTaskServ().addReqtoTask(idtask, idReq);
    print(s);
  }

  submit() async {
    if (subtasks_list.isNotEmpty) {
      Task t = new Task(
          requesting_entity: requesting_entity.text,
          task_type: choosentasktype.id,
          begin_date: date);
      addTask(t);

      await getTaskID(t.requesting_entity, t.task_type);
      print(idTask);
      for (var i = 0; i < subtasks_list.length; i++) {
        subtasks_list[i].task_id = idTask;
        await addsubtask(subtasks_list[i]);
        await getSubtaskID(subtasks_list[i].name);
        for (var j = 0; j < subtasks_list[i].requirements.length; j++) {
          await addReqtoTask(idSubTask, subtasks_list[i].requirements[j].id);
        }
      }
      Toast.show("The task has been added ", context,
          duration: 2, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Please add subtasks for this task", context,
          duration: 2, gravity: Toast.BOTTOM);
    }
  }

  Widget _buildContainer(Widget w) {
    return Container(
        padding: EdgeInsets.all(10),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTaskType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('Add Task'),
        leading: Badge(fun: () {
          scaffoldKey.currentState.openDrawer();
        }),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildContainer(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Requesting Entity :',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: TextFormField(
                          controller: requesting_entity,
                          decoration: InputDecoration(
                            hintText: "The entity thtat asked for this task",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'required';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Task Type :',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          loading
                              ? CircularProgressIndicator()
                              : tasktype.isEmpty
                                  ? Text("no task type found")
                                  : Flexible(
                                      child: DropdownButton(
                                          iconEnabledColor: Colors.purple,
                                          elevation: 20,
                                          style: TextStyle(color: Colors.white),
                                          value: valueChoose,
                                          items: listitem(),
                                          onChanged: (value) {
                                            if (value != valueChoose) {
                                              setState(() {
                                                valueChoose = value;
                                                choosentasktype = tasktype
                                                    .firstWhere((element) =>
                                                        element.name_of_task ==
                                                        valueChoose);
                                                print(choosentasktype);
                                              });
                                            }
                                          }),
                                    ),
                          IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(AddTaskType.routeName,
                                        arguments: tasktype)
                                    .then((value) {
                                  getTaskType();
                                });
                              })
                        ],
                      ),
                    ])),
                SizedBox(
                  height: 30,
                ),
                _buildContainer(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Begin Date :',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              date == null
                                  ? 'No date choosen yet'
                                  : DateFormat.yMMMd().format(date).toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          FlatButton(
                              onPressed: _datepiker,
                              child: Text(
                                'choose a date',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).accentColor),
                              ))
                        ],
                      ),
                    ])),
                SizedBox(
                  height: 20,
                ),
                _buildContainer(
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Subtasks :',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FlatButton(
                          onPressed: _movetosubtaskscreen,
                          child: Text(
                            'Subtasks List',
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).accentColor),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'ADD',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () {
                        if (!_key.currentState.validate()) {
                          return;
                        } else
                          submit();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
