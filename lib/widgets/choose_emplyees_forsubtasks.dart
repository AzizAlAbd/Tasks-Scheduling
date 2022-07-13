import 'package:flutter/material.dart';
import 'package:new_app/models/requirement.dart';
import 'package:new_app/services/noti_serv.dart';
import 'package:new_app/services/req_serv.dart';
import 'package:new_app/services/subtask_serv.dart';
import 'package:new_app/widgets/checkboxlisttilebuild.dart';
import 'package:toast/toast.dart';
import '../dummy_data.dart';
import '../models/employee.dart';
import '../services/emp_serv.dart';

class ChooseEmplyees extends StatefulWidget {
  final String id;
  ChooseEmplyees(this.id);
  @override
  _ChooseEmplyeesState createState() => _ChooseEmplyeesState();
}

class _ChooseEmplyeesState extends State<ChooseEmplyees> {
  List<Employee> employees;
  List<requirement> reqs;
  bool loading = true;
  bool loading2 = true;
  getAllEmployee() async {
    employees = await EmployeeService().getData();
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
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        "choose employee",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      children: [
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).accentColor, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: loading
              ? Center(child: CircularProgressIndicator())
              : employees.isEmpty
                  ? Center(
                      child: Text(
                        "There isn't any employee in the system ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          ...employees.map((emp) {
                            //getReqEmp(emp.id);
                            return CheckBoxTileBuild(emp);
                          }).toList()
                        ],
                      ),
                    ),
        ),
        Center(
          child: RaisedButton(
            child: Text(
              'submit',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              List<Employee> choosenemps =
                  employees.where((element) => element.check == true).toList();
              /*for (var i = 0; i < choosenemps.length; i++) {
                assigne(widget.id, choosenemps[i].id);
                /*addnot(widget.id, choosenemps[i].id,
                    "there is a subtask is assgined for you , do u accept it ?");*/
              }
              Toast.show("requests to the employees have been sent", context,
                  duration: 2, gravity: Toast.BOTTOM);*/
              Navigator.of(context).pop(choosenemps);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Theme.of(context).accentColor,
          ),
        )
      ],
    );
  }
}

/*return SimpleDialog(
        contentPadding: EdgeInsets.all(15),
        title: Text(
          'Choose Employees for this subtask',
          style: TextStyle(color: Colors.blue[800], fontSize: 24),
        ),
        children: [
          Column(
            children: [
              Container(
                  padding: EdgeInsets.all(5),
                  height: 300,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue[800]),
                      borderRadius: BorderRadius.circular(10)),
                  child: loading
                      ? CircularProgressIndicator()
                      : employees.isNotEmpty
                          ? ListView.builder(itemBuilder: (ctx, index) {
                              return Card(
                                child: CheckboxListTile(
                                  value: employees[index].check,
                                  onChanged: (value) {
                                    setState(() {
                                      employees[index].check = value;
                                    });
                                  },
                                  title: Text(
                                    employees[index].name,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  /*subtitle: Wrap(
                                      direction: Axis.horizontal,
                                      children: [
                                        ...emp.skills.map((skill) {
                                          return Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.deepPurple),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Text(
                                              skill.name,
                                              style: TextStyle(
                                                  color: Colors.deepPurple),
                                            ),
                                          );
                                        }).toList()
                                      ],
                                    ),*/
                                ),
                              );
                            })
                          : Center(
                              child:
                                  Text('There is no employee for this subtask'),
                            )),
              Container(
                width: 100,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          )
        ]);
  }
}*/
