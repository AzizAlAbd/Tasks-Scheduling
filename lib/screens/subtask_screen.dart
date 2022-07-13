import 'package:flutter/material.dart';
import 'package:new_app/widgets/add_suptask.dart';
import '../models/subtask.dart';
import '../widgets/subtask_widget.dart';

class SubtaskScreen extends StatefulWidget {
  static const routeName = '/SubtaskScreen';
  @override
  _SubtaskScreenState createState() => _SubtaskScreenState();
}

class _SubtaskScreenState extends State<SubtaskScreen> {
  List<SubTask> subtasks_list = [];
  void deleteSubTask(String id) {
    setState(() {
      subtasks_list.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    subtasks_list = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Subtasks for this task '),
        ),
        body: Container(
            margin: EdgeInsets.all(10),
            child: subtasks_list.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/emptyfile2.jpg',
                        height: 200,
                        width: 200,
                        color: Theme.of(context).accentColor,
                      ),
                      Center(
                        child: Text(
                          'No subtasks added yet!',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemBuilder: (ctx, index) {
                      return SubTaskDetails(
                          subtasks_list[index], index, deleteSubTask);
                    },
                    itemCount: subtasks_list.length,
                  )),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Addsubtask();
                }).then((value) {
              if (value == null) {
                return;
              } else {
                setState(() {
                  subtasks_list.add(value);
                });
              }
            });
          },
        ));
  }
}
