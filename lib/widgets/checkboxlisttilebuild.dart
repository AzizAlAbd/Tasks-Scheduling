import 'package:flutter/material.dart';
import 'package:new_app/models/employee.dart';
import 'package:new_app/models/requirement.dart';
import 'package:new_app/services/req_serv.dart';

class CheckBoxTileBuild extends StatefulWidget {
  final Employee emp;
  CheckBoxTileBuild(this.emp);

  @override
  _CheckBoxTileBuildState createState() => _CheckBoxTileBuildState();
}

class _CheckBoxTileBuildState extends State<CheckBoxTileBuild> {
  List<requirement> reqs;
  bool loading = true;
  getReqEmp(String id) async {
    reqs = await RequirementService().getReqEmp(id);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReqEmp(widget.emp.id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(3),
      child: CheckboxListTile(
        value: widget.emp.check,
        onChanged: (val) {
          setState(() {
            widget.emp.check = val;
          });
        },
        title: Text(
          widget.emp.name,
          style: TextStyle(fontSize: 18),
        ),
        subtitle: loading
            ? CircularProgressIndicator()
            : Wrap(
                direction: Axis.horizontal,
                runSpacing: 4,
                spacing: 4,
                children: [
                  ...reqs.map((skill) {
                    return Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(top: 5, left: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        skill.name,
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                    );
                  }).toList()
                ],
              ),
      ),
    );
    ;
  }
}
