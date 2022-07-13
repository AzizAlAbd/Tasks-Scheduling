import 'package:flutter/material.dart';
import 'package:new_app/models/requirement.dart';
import '../models/requirement.dart';
import '../services/req_serv.dart';
import 'package:toast/toast.dart';

class AddRequirement extends StatelessWidget {
  static const routeName = '/AddRequirement';
  final _key = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final descrcontroller = TextEditingController();

  void submit() {
    String name = namecontroller.text;
    String desc = descrcontroller.text;
    if (name.isNotEmpty) {
      requirement req = new requirement(
          id: DateTime.now().toString(), name: name, description: desc);
      namecontroller.clear();
      descrcontroller.clear();
    }
  }

  Widget _buildContainer(BuildContext context, Widget w) {
    return Container(
        height: 350,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
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

  add(requirement req) async {
    await RequirementService().addRequirement(req);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Requirement'),
      ),
      body: _buildContainer(
        context,
        Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Requirement Title :',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple[700]),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: TextFormField(
                  decoration:
                      InputDecoration(hintText: "Enter the requirement title"),
                  controller: namecontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Description(not required) :',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple[700]),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Enter description for this requirement",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
                controller: descrcontroller,
                maxLines: 3,
              ),
              SizedBox(
                height: 20,
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
                      requirement req = new requirement(
                          name: namecontroller.text,
                          description: descrcontroller.text);
                      add(req);
                      namecontroller.clear();
                      descrcontroller.clear();
                      Toast.show("The requirement has been added", context,
                          gravity: Toast.BOTTOM, duration: 2);
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.deepPurple[400],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
