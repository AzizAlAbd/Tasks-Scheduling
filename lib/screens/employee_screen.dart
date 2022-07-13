import 'package:flutter/material.dart';
import 'package:new_app/models/employee.dart';

import 'package:new_app/screens/add_Employee_Screen.dart';
import 'package:new_app/widgets/drawer_widget.dart';
import 'package:new_app/widgets/employee_widget.dart';

import '../widgets/badge.dart';
import '../services/emp_serv.dart';

class EmployeesScreen extends StatefulWidget {
  static const routeName = '/EmployeesScreen';

  @override
  _EmployeesScreenState createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Employee> employees;
  List<Employee> searchemployees;
  bool _floded = true;
  bool loading = true;

  void deleteEmp(String id) async {
    await EmployeeService().deleteEmployee(id);
    setState(() {
      getAllEmployee();
    });
  }

  getAllEmployee() async {
    employees = await EmployeeService().getData();
    searchemployees = employees;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllEmployee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: DrawerWidget(),
        appBar: AppBar(
          title: Text('Employees'),
          leading: Badge(fun: () {
            scaffoldKey.currentState.openDrawer();
          }),
          actions: [
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              width: _floded ? 48 : 290,
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
                                    hintStyle: TextStyle(color: Colors.purple),
                                  ),
                                  onSubmitted: (value) {
                                    setState(() {
                                      searchemployees = searchemployees
                                          .where((element) =>
                                              element.name == value)
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
                          searchemployees = employees;
                        });
                      }),
                ],
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AddEmployeePage.routeName)
                      .then((value) {
                    setState(() {
                      getAllEmployee();
                    });
                  });
                }),
          ],
        ),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : employees.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/OurLogo.jpg',
                          width: 200,
                          height: 200,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'NO EMPOLYEES YET IN THE SYSTEM',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (ctx, index) {
                      return EmployeeWidget(searchemployees[index], deleteEmp);
                    },
                    itemCount: searchemployees.length,
                  ));
  }
}
