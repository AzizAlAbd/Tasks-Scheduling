import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_app/models/noification.dart';
import 'package:new_app/models/task.dart';
import 'package:new_app/screens/notification_screen.dart';
import 'package:new_app/services/noti_serv.dart';
import 'package:new_app/widgets/badge.dart';

import 'package:new_app/widgets/drawer_widget.dart';
import '../widgets/task_widget.dart';
import '../services/task_serv.dart';

import '../widgets/sliverappbar_widget.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/MainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final scafoldKey = GlobalKey<ScaffoldState>();
  List<Task> avaliableTasks = [];
  List<MyNotification> avaliablenots;
  FlutterLocalNotificationsPlugin localNotification;
  bool _floded = true;
  bool loading = true;
  getTask() async {
    Task.tasks = await TaskServ().getData();
    avaliableTasks = Task.tasks
        .where((element) =>
            element.status == "NotAssigned" ||
            element.status == "Active" ||
            element.status == "Outofdeadline")
        .toList();

    setState(() {
      loading = false;
    });
  }

  getnots() async {
    List<MyNotification> nots =
        await NotifcationServ().getNotificationData("1");
    avaliablenots = nots.where((element) => element.read == "2").toList();
    print(avaliablenots);
    var androidDetailes = new AndroidNotificationDetails(
      "channelId",
      "Local Notification",
      "whatever",
      importance: Importance.high,
      fullScreenIntent: true,
      color: Colors.red,
    );
    var generalDetailes = new NotificationDetails(android: androidDetailes);
    for (var i = 0; i < avaliablenots.length; i++) {
      String title;
      switch (avaliablenots[i].type) {
        case "Accept":
          title = "There is an employee accepted his/her assignement";

          break;
        case "Reject":
          title = "There is an employee refused his/her assignement";

          break;
        case "Finish":
          title =
              "There is an employee ask for you approval on his/her assignement";

          break;
        case "Report":
          title = "You have a report from an employee";

          break;

        default:
      }
      await localNotification.show(
        i,
        "Task2Do",
        title,
        generalDetailes,
      );
      await NotifcationServ().updateRead(avaliablenots[i].id, "0");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var a = new AndroidInitializationSettings("ic_launcher");
    var i = new InitializationSettings(android: a);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(i, onSelectNotification: tapnot);
    getTask();
    getnots();
  }

  Future<dynamic> tapnot(String payload) {
    Navigator.of(context).pushReplacementNamed(NotificationScreen.routeName);
  }

  void opendrwer() {
    scafoldKey.currentState.openDrawer();
  }

/*
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var a = new AndroidInitializationSettings("ic_launcher");
    var i = new InitializationSettings(android: a);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(i);
  }

  Future shownot() async {
    var androidDetailes = new AndroidNotificationDetails(
      "channelId",
      "Local Notification",
      "whatever",
      importance: Importance.high,
      fullScreenIntent: true,
      color: Colors.red,
    );
    var generalDetailes = new NotificationDetails(android: androidDetailes);
    for (var i = 0; i < 2; i++) {
      await localNotification.show(
        i,
        "Its a test ",
        "this is my body",
        generalDetailes,
      );
    }
  }*/
  @override
  Widget build(BuildContext context) {
    getTask();

    return Scaffold(
        key: scafoldKey,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                leading: Badge(
                  fun: opendrwer,
                ),
                pinned: true,
                toolbarHeight: 70,
                elevation: 20,
                expandedHeight: 120,
                shape: RoundedRectangleBorder(
                    /* borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        )*/
                    ),
                stretch: true,
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
                                            avaliableTasks = avaliableTasks
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
                            icon: _floded
                                ? Icon(Icons.search)
                                : Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                _floded = !_floded;
                                avaliableTasks = Task.tasks
                                    .where((element) =>
                                        element.status == "NotAssigned" ||
                                        element.status == "Active" ||
                                        element.status == "Outofdeadline")
                                    .toList();
                              });
                            }),
                      ],
                    ),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: [StretchMode.fadeTitle],
                  title: Text(
                    'TASKS2DO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  centerTitle: true,
                  titlePadding: EdgeInsets.only(bottom: 10),
                )),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            loading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : avaliableTasks.isEmpty
                    ? SliverToBoxAdapter(
                        child: Center(
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
                      ))
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                        return TaskWidget(avaliableTasks[index]);
                      }, childCount: avaliableTasks.length))
          ],
        ),
        drawer: DrawerWidget());
  }
}
