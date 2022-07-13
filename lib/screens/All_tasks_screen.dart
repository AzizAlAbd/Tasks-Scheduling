import 'package:flutter/material.dart';
import 'package:new_app/models/task.dart';
import 'package:new_app/services/task_serv.dart';
import 'package:new_app/widgets/drawer_widget.dart';
import 'package:new_app/widgets/task_widget.dart';

import '../widgets/badge.dart';

class AllTask extends StatefulWidget {
  static const routeName = '/AllTask';

  @override
  _AllTaskState createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _floded = true;
  List<Task> tasks = [];
  List<Task> searshtasks = [];
  bool loading = true;
  getTask() async {
    tasks = await TaskServ().getData();
    searshtasks = tasks;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(),
        key: scaffoldKey,
        appBar: AppBar(
            title: Text('All Tasks'),
            leading: Badge(fun: () {
              scaffoldKey.currentState.openDrawer();
            }),
            actions: [
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                width: _floded ? 48 : 330,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.only(left: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: !_floded
                                ? TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search',
                                      hintStyle:
                                          TextStyle(color: Colors.purple),
                                    ),
                                    onSubmitted: (value) {
                                      setState(() {
                                        searshtasks = searshtasks
                                            .where((element) =>
                                                element.task_type_name ==
                                                    value ||
                                                element.requesting_entity ==
                                                    value)
                                            .toList();
                                      });
                                    },
                                  )
                                : null)),
                    IconButton(
                        icon: _floded ? Icon(Icons.search) : Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _floded = !_floded;
                            searshtasks = tasks;
                          });
                        }),
                  ],
                ),
              ),
            ]),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : tasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Image.asset(
                          'assets/images/OurLogo.jpg',
                          width: 200,
                          height: 200,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'NO TASK YET IN THE SYSTEM',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (ctx, index) {
                      return TaskWidget(searshtasks[index]);
                    },
                    itemCount: searshtasks.length,
                  ));
  }
}
