import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:new_app/models/requirement.dart';
import 'package:new_app/models/subtask.dart';
import '../models/requirement.dart';
import 'package:intl/intl.dart';
import 'choose_requirements.dart';

class Addsubtask extends StatefulWidget {
  @override
  _AddsubtaskState createState() => _AddsubtaskState();
}

class _AddsubtaskState extends State<Addsubtask> {
  DateTime startdate = null;
  DateTime enddate = null;
  List<requirement> requiremets = [];
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  /*static List<bool> values = new List()[requiremets.length];
  set val(_) {
    values.map((value) {
      value = false;
    });
  }*/

  final _key = GlobalKey<FormState>();

  Widget _buildRow(int flatButtonNum, DateTime date) {
    return Row(
      children: [
        Expanded(
          child: Text(
            date == null
                ? 'No date '
                : DateFormat.yMMMd().format(date).toString(),
            style: TextStyle(fontSize: 18),
          ),
        ),
        FlatButton(
            onPressed: () => _datepiker1(flatButtonNum),
            child: Text(
              'choose a date',
              style:
                  TextStyle(fontSize: 18, color: Theme.of(context).accentColor),
            ))
      ],
    );
  }

  void _datepiker1(int flatButtonNum) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2025))
        .then((value) {
      if (value == null) {
        return;
      }
      if (flatButtonNum == 1) {
        setState(() {
          startdate = value;
        });
      }
      if (flatButtonNum == 2) {
        setState(() {
          enddate = value;
        });
      }
    });
  }

  void add() {
    if (titleController == null ||
        descriptionController == null ||
        requiremets.isEmpty ||
        startdate == null ||
        enddate == null) {
      return;
    } else {
      SubTask subTask = new SubTask(
        name: titleController.text,
        start_date: startdate,
        end_date: enddate,
        description: descriptionController.text,
        requirements: requiremets,
      );
      Navigator.of(context).pop(subTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Form(
              key: _key,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Subtask Title :',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                            hintText: "Enter the subtask title"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Start Date :',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildRow(1, startdate),
                    Text(
                      'End Date :',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildRow(2, enddate),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Description :',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      maxLines: 3,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 210,
                      child: FlatButton(
                        focusColor: Theme.of(context).accentColor,
                        child: Text(
                          'Choose Requiremetns',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                          textAlign: TextAlign.start,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return RequirementsDialog('Requirements');
                              }).then((list) => print(requiremets = list));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: add,
                      child: Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
                  ])),
        ),
      ],
    );
  }
}
