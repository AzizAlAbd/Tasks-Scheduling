import 'package:flutter/material.dart';
import 'package:new_app/screens/add_requirement_screen.dart';
import '../models/requirement.dart';
import '../services/req_serv.dart';

class RequirementsDialog extends StatefulWidget {
  final String title;
  RequirementsDialog(this.title);
  @override
  _RequirementsDialogState createState() => _RequirementsDialogState();
}

class _RequirementsDialogState extends State<RequirementsDialog> {
  List<requirement> requiremets = [];
  List<requirement> checkedrequriements = [];
  bool loading = true;
  getAllreq() async {
    requiremets = await RequirementService().getData();

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllreq();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        widget.title,
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
              : requiremets.isEmpty
                  ? Center(
                      child: Text(
                        "There isn't any skills or requirement added in the system ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          ...requiremets.map((req) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              child: CheckboxListTile(
                                value: req.check,
                                onChanged: (val) {
                                  setState(() {
                                    req.check = val;
                                  });
                                },
                                title: Text(
                                  req.name,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            );
                          }).toList()
                        ],
                      ),
                    ),
        ),
        Container(
          width: 200,
          child: FlatButton(
            onPressed: () => Navigator.of(context)
                .pushNamed(AddRequirement.routeName)
                .then((value) {
              setState(() {
                getAllreq();
              });
            }),
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                'Add One',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 18, color: Theme.of(context).accentColor),
              ),
            ),
          ),
        ),
        Center(
          child: RaisedButton(
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              Navigator.of(context)
                  .pop(requiremets.where((element) => element.check).toList());
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
