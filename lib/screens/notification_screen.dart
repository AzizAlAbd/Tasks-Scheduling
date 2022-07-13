import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:new_app/models/noification.dart';
import 'package:new_app/screens/notification_details_screen.dart';
import 'package:new_app/services/noti_serv.dart';
import 'package:new_app/widgets/badge.dart';
import 'package:new_app/widgets/drawer_widget.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = "/NotificationScreen";

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<MyNotification> nots;
  bool loading = true;
  getnots() async {
    nots = await NotifcationServ().getNotificationData("1");
    setState(() {
      loading = false;
    });
  }

  updateread(String id) async {
    String s = await NotifcationServ().updateRead(id, "1");
    print(s);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getnots();
  }

  @override
  Widget build(BuildContext context) {
    getnots();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Notifications"),
        leading: Badge(fun: () {
          scaffoldKey.currentState.openDrawer();
        }),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                String title;
                Color color;
                switch (nots[index].type) {
                  case "Accept":
                    title = "There is an employee accepted his/her assignement";
                    color = Colors.greenAccent;
                    break;
                  case "Reject":
                    title = "There is an employee refused his/her assignement";
                    color = Colors.red;
                    break;
                  case "Finish":
                    title =
                        "There is an employee ask for you approval on his/her assignement";
                    color = Colors.blue;
                    break;
                  case "Report":
                    title = "You have a report from an employee";
                    color = Colors.grey;
                    break;

                  default:
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                  child: Card(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        onTap: () => Navigator.of(context).pushNamed(
                            NotifiactionDetailsScreen.routeName,
                            arguments: {
                              "not": nots[index],
                              "title": title
                            }).then((value) {
                          updateread(value);
                        }),
                        leading: Container(
                          width: 15,
                          color: color,
                        ),
                        title: Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: nots[index].read == "1"
                                  ? Colors.black54
                                  : Colors.black),
                        ),
                        subtitle: Text(DateFormat.yMMMMEEEEd()
                            .format(DateTime.now())
                            .toString()),
                      ),
                    ),
                  ),
                );
                /**/
              },
              itemCount: nots.length,
            ),
      drawer: DrawerWidget(),
    );
  }
}
