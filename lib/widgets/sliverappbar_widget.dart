import 'package:flutter/material.dart';
import '../widgets/badge.dart';

class SliverAppBarWidget extends StatefulWidget {
  final Function fun;
  SliverAppBarWidget(this.fun);
  @override
  _SliverAppBarWidgetState createState() => _SliverAppBarWidgetState();
}

class _SliverAppBarWidgetState extends State<SliverAppBarWidget> {
  bool _floded = true;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        leading: Badge(
          fun: widget.fun,
        ),
        pinned: true,
        toolbarHeight: 70,
        elevation: 20,
        expandedHeight: 120,
        shape: RoundedRectangleBorder(
            /* borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        )*/
            ),
        stretch: true,
        actions: [
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            width: _floded ? 48 : 330,
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
                                  print(value);
                                },
                              )
                            : null)),
                IconButton(
                    icon: _floded ? Icon(Icons.search) : Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _floded = !_floded;
                      });
                    }),
              ],
            ),
          )
        ],
        flexibleSpace: FlexibleSpaceBar(
          stretchModes: [StretchMode.fadeTitle],
          title: Text(
            'TASKS2DO',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          titlePadding: EdgeInsets.only(bottom: 10),
        ));
  }
}
