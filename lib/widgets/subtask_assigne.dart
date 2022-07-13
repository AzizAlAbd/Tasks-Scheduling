import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_app/models/employee.dart';
import 'package:new_app/models/requirement.dart';
import 'package:new_app/models/subtask.dart';
import '../models/subtask.dart';
import '../widgets/choose_emplyees_forsubtasks.dart';
import '../services/req_serv.dart';

class SubTaskAssigne extends StatefulWidget {
  final SubTask subtask;
  final Function f;
  SubTaskAssigne(this.subtask, this.f);

  @override
  _SubTaskAssigneState createState() => _SubTaskAssigneState();
}

class _SubTaskAssigneState extends State<SubTaskAssigne> {
  List<requirement> reqs = [];
  List<Employee> emps = [];
  bool loading = true;
  getReq() async {
    reqs = await RequirementService().getReqtask(widget.subtask.id);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReq();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).accentColor,
                offset: Offset.zero,
                blurRadius: 6,
                spreadRadius: 2)
          ]),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.subtask.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Theme.of(context).accentColor),
                ),
                Divider(
                  thickness: 2,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text(
                    ' ${DateFormat.yMMMd().format(widget.subtask.start_date).toString()}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).accentColor),
                  ),
                  Icon(Icons.arrow_forward),
                  Text(
                    ' ${DateFormat.yMMMd().format(widget.subtask.end_date).toString()}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).accentColor),
                  ),
                ]),
                Divider(
                  thickness: 2,
                ),
                Text(
                  '${widget.subtask.description}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).accentColor),
                ),
                Divider(
                  thickness: 2,
                ),
                loading
                    ? CircularProgressIndicator()
                    : Wrap(
                        direction: Axis.horizontal,
                        runSpacing: 4,
                        spacing: 4,
                        children: [
                          ...reqs.map((req) {
                            return Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).accentColor),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                req.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Theme.of(context).accentColor),
                              ),
                            );
                          }).toList()
                        ],
                      )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                icon: Icon(
                  Icons.assignment_ind,
                  size: 60,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ChooseEmplyees(widget.subtask.id);
                      }).then((value) {
                    if (value != null) {
                      emps = value;
                      widget.f(emps, widget.subtask.id, context);
                      print(emps);
                    } else {}
                  });
                }),
          )
        ],
      ),
    );
  }
}
