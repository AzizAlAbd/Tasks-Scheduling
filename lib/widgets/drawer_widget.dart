import 'package:flutter/material.dart';
import 'package:new_app/models/noification.dart';
import 'package:new_app/screens/All_tasks_screen.dart';
import 'package:new_app/screens/login_screen.dart';
import 'package:new_app/screens/notification_screen.dart';
import 'package:new_app/services/noti_serv.dart';
import '../screens/main_screen.dart';

import '../screens/define_project_screen.dart';
import '../screens/employee_screen.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<MyNotification> nots;
  bool loading = true;
  getnots() async {
    nots = await NotifcationServ().getNotificationData("1");
    nots = nots.where((element) => element.read == "0").toList();
    setState(() {
      loading = false;
    });
  }

  Widget _ListTileBuilder(BuildContext ctx, IconData icon, String title,
      String routeName, Widget trall) {
    return ListTile(
      leading: Icon(
        icon,
        size: 35,
        color: Theme.of(ctx).accentColor,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(ctx).accentColor),
      ),
      onTap: () {
        Navigator.of(ctx).pushReplacementNamed(routeName);
      },
      trailing: trall,
    );
  }

  @override
  Widget build(BuildContext context) {
    getnots();
    return Container(
      width: 300,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.white,
            Colors.white.withOpacity(0.9),
            Theme.of(context).primaryColor.withOpacity(0.9)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(80),
            topRight: Radius.circular(80),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
            child: Image.asset(
              'assets/images/OurLogo.jpg',
              width: 100,
              height: 100,
            ),
          ),
          Text(
            "Tasks2Do",
            style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          _ListTileBuilder(
              context, Icons.home, "The Main Page", MainScreen.routeName, null),
          _ListTileBuilder(
              context, Icons.assignment, "All Tasks", AllTask.routeName, null),
          _ListTileBuilder(context, Icons.library_add, "Add A Task",
              DefineProject.routeName, null),
          _ListTileBuilder(context, Icons.people, "Employee",
              EmployeesScreen.routeName, null),
          _ListTileBuilder(
              context,
              Icons.notifications,
              "Notifications",
              NotificationScreen.routeName,
              loading
                  ? CircularProgressIndicator()
                  : nots.length != 0
                      ? CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 15,
                          child: Text(
                            nots.length.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        )
                      : Container()),
          Spacer(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              size: 35,
              color: Colors.red,
            ),
            title: Text(
              'Log Out',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(LogInScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
