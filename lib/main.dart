import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_app/models/employee.dart';
import 'package:new_app/screens/login_screen.dart';
import 'package:new_app/screens/main_screen.dart';
import 'package:new_app/screens/employee_screen.dart';
import 'package:new_app/screens/employee_tasks_screen.dart';
import 'package:new_app/screens/subtask_screen.dart';
import 'package:new_app/screens/subtasks_for_thetask_screen.dart';
import './screens/add_Employee_Screen.dart';
import 'package:new_app/screens/define_project_screen.dart';
import 'screens/add_task_type_screen.dart';
import 'screens/add_requirement_screen.dart';
import './screens/All_tasks_screen.dart';
import './screens/notification_screen.dart';
import './screens/notification_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'task scheduling',
      theme: ThemeData(
        fontFamily: 'RobotoCondensed',
        primarySwatch: Colors.purple,
        accentColor: Colors.deepPurple,
        canvasColor: Colors.purple[50],
      ),
      initialRoute: LogInScreen.routeName,
      routes: {
        LogInScreen.routeName: (ctx) => LogInScreen(),
        MainScreen.routeName: (ctx) => MainScreen(),
        DefineProject.routeName: (ctx) => DefineProject(),
        AddRequirement.routeName: (ctx) => AddRequirement(),
        AddEmployeePage.routeName: (ctx) => AddEmployeePage(),
        AddTaskType.routeName: (ctx) => AddTaskType(),
        SubtaskScreen.routeName: (ctx) => SubtaskScreen(),
        EmployeesScreen.routeName: (ctx) => EmployeesScreen(),
        EmployeeTasks.routeName: (ctx) => EmployeeTasks(),
        SubtasksDetails.routeName: (ctx) => SubtasksDetails(),
        AllTask.routeName: (ctx) => AllTask(),
        NotificationScreen.routeName: (ctx) => NotificationScreen(),
        NotifiactionDetailsScreen.routeName: (ctx) =>
            NotifiactionDetailsScreen()
      },
    );
  }
}
