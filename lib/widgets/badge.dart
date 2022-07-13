import 'package:flutter/material.dart';
import 'package:new_app/models/noification.dart';
import 'package:new_app/services/noti_serv.dart';

class Badge extends StatefulWidget {
  const Badge({
    Key key,
    @required this.fun,
  }) : super(key: key);

  final Function fun;

  @override
  _BadgeState createState() => _BadgeState();
}

class _BadgeState extends State<Badge> {
  List<MyNotification> nots;
  bool loading = true;
  getnots() async {
    nots = await NotifcationServ().getNotificationData("1");
    nots = nots.where((element) => element.read == "0").toList();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    getnots();
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(icon: Icon(Icons.menu), onPressed: widget.fun),
        loading
            ? Positioned(
                right: 8,
                top: 8,
                child: CircularProgressIndicator(),
              )
            : nots.length == 0
                ? Positioned(
                    right: 8,
                    top: 8,
                    child: Container(),
                  )
                : Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      // color: Theme.of(context).accentColor,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.red,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        nots.length.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  )
      ],
    );
  }
}
