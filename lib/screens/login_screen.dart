import 'package:flutter/material.dart';
import 'package:new_app/screens/main_screen.dart';
import '../screens/main_screen.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = 'LogInScreen';
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _key = GlobalKey<FormState>();
  final passwordcontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  bool b = true;
  @override
  void initstate() {
    usernamecontroller.addListener(() => setState(() {}));
    passwordcontroller.addListener(() => setState(() {}));
    super.initState();
  }

  void showPassword() {
    setState(() {
      if (!b)
        b = true;
      else
        b = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            Text(
              "Login",
              style: TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Welcome to Task2Do",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              padding:
                  EdgeInsets.only(top: 60, left: 15, right: 15, bottom: 25),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset.zero,
                    blurRadius: 10,
                    spreadRadius: 1)
              ], color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernamecontroller,
                      cursorColor: Theme.of(context).primaryColor,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Theme.of(context).primaryColor,
                          ),
                          suffixIcon: usernamecontroller.text.isEmpty
                              ? Container(
                                  width: 0,
                                )
                              : IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    usernamecontroller.clear();
                                  }),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Theme.of(context).primaryColor),
                          ),
                          errorStyle: TextStyle(fontSize: 16)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your email first';
                        } else if (value != "abdazizabd@gmail.com") {
                          return 'Your email not correct try again';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: b,
                      controller: passwordcontroller,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Theme.of(context).primaryColor,
                          ),
                          suffixIcon: !b
                              ? IconButton(
                                  icon: Icon(
                                    Icons.visibility_off,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: showPassword)
                              : IconButton(
                                  icon: Icon(
                                    Icons.visibility,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: showPassword),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Theme.of(context).primaryColor),
                          ),
                          errorStyle: TextStyle(fontSize: 16)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your password first';
                        } else if (value != "0991872415") {
                          return 'Your password not correct try again';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      onPressed: () {
                        if (!_key.currentState.validate()) {
                          return;
                        } else
                          Navigator.of(context)
                              .pushReplacementNamed(MainScreen.routeName);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: 120,
                          height: 40,
                          child: Text(
                            'Log In',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
