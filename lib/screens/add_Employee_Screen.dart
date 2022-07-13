import 'dart:io';

import 'package:flutter/material.dart';

import 'package:new_app/services/emp_serv.dart';
import 'package:toast/toast.dart';
import '../models/requirement.dart';
import '../widgets/choose_requirements.dart';
import '../models/employee.dart';

class AddEmployeePage extends StatefulWidget {
  static const routeName = '/EmployeePage';

  @override
  _AddEmployeePageState createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  List<requirement> skills;
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final _key = GlobalKey<FormState>();
  String id;
  bool loading = true;
  Widget _buildContainer(Widget w) {
    return Container(
        padding: EdgeInsets.all(15),
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

  add(Employee emp) async {
    await EmployeeService().addEmpolyee(emp);
  }

  getId(String name) async {
    id = await EmployeeService().getID(name);
    setState(() {
      loading = false;
    });
  }

  addReqtoEmp(String eid, String rid) async {
    String res = await EmployeeService().addReqtoEmp(eid, rid);
    print(res);
  }

  submit() async {
    Employee employee = new Employee(
        name: name.text, email: email.text, phoneNumber: phone.text);
    if (skills != null) {
      add(employee);

      await getId(name.text);

      for (var i = 0; i < skills.length; i++) {
        print(skills[i].id);
        print(id);
        addReqtoEmp(id, skills[i].id);
      }
      name.clear();
      email.clear();
      phone.clear();
      Toast.show("Employee has been added", context,
          gravity: Toast.BOTTOM, duration: 2);
    } else {
      Toast.show("please choose the employee's skills first ", context,
          gravity: Toast.BOTTOM, duration: 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Employee',
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
            key: _key,
            child: ListView(
              children: [
                _buildContainer(Column(children: [
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Name',
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email',
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: phone,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: 'Phone Number',
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                  )
                ])),
                SizedBox(height: 20),
                _buildContainer(
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Skills :',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return RequirementsDialog('Skills');
                              }).then((list) {
                            skills = list;
                            print(skills);
                          });
                        },
                        child: Text(
                          'Skills List',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
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
                      } else {
                        submit();
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Theme.of(context).accentColor,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
