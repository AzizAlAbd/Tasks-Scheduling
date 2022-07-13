import 'package:flutter/material.dart';
import '../models/subtask.dart';
import 'package:intl/intl.dart';

class SubTaskDetails extends StatelessWidget {
  final SubTask subTask;
  final int index;
  final Function delete;
  SubTaskDetails(this.subTask, this.index, this.delete);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        child: ListTile(
          contentPadding: EdgeInsets.all(15),
          leading: CircleAvatar(
            radius: 23,
            child: Text(
              '${index + 1}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            backgroundColor: Theme.of(context).accentColor,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subTask.name,
                style: TextStyle(fontSize: 18),
              ),
              Divider(
                color: Theme.of(context).accentColor,
              )
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Start Date :'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    DateFormat.yMMMd().format(subTask.start_date).toString(),
                  )
                ],
              ),
              Row(
                children: [
                  Text('End Date :'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    DateFormat.yMMMd().format(subTask.end_date).toString(),
                  )
                ],
              ),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              Wrap(
                direction: Axis.horizontal,
                runSpacing: 4,
                spacing: 4,
                children: [
                  ...subTask.requirements.map((req) {
                    return Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(req.name),
                    );
                  }).toList()
                ],
              )
            ],
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.delete,
                size: 35,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () => delete(subTask.id)),
        ),
      ),
    );
  }
}
