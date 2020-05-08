import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/subjects.dart';
import 'views/login.dart';
import 'style.dart';
import 'models/student_model.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  SharedPreferences sharedPreferences;
  bool loggedIn = false;
  Student student;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool("logged_in") == null) {
      setState(() {
        loggedIn = false;
      });
    } else {
      var studentLoad = jsonDecode(sharedPreferences.getString("student"));
      student = Student(
          studentID: studentLoad['student_id'],
          username: studentLoad['username'],
          password: studentLoad['password'],
          subject: studentLoad['subject']);
      setState(() {
        loggedIn = true;
      });
    }
  }

  Widget home() {
    if (loggedIn) {
      return SubjectsFutureBuilder(student: student);
    } else {
      return LoginFutureBuilder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: home(),
        theme: ThemeData(
            primaryColor: primaryColor, scaffoldBackgroundColor: Colors.white));
  }
}
