import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/subject_model.dart';
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
    checkLoginStatus(); // Проверяем авторизован или нет
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // Если нет записи в sharedPrefs, значит не авторизован
    if (sharedPreferences.getString("student_data") == null) {
      setState(() {
        loggedIn = false;
      });
    } else {
      // Сохраненные данные о студенте в sharedPrefs в JSON
      var studentLoad = jsonDecode(sharedPreferences.getString("student_data"));
      List<dynamic> subjects = studentLoad['subject']
          .map((dynamic item) => Subject.fromJson(item))
          .toList();
      // Переводим в объект класса Student
      student = Student(
          studentID: studentLoad['student_id'],
          username: studentLoad['username'],
          subject: subjects);
      setState(() {
        loggedIn = true;
      });
    }
  }

  // Выводить страницу с предметами или страницу авторизации
  Widget home() {
    if (loggedIn) {
      return SubjectsFutureBuilder(student: student);
    } else {
      return Login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: home(),
        theme: ThemeData(
            primaryColor: primaryColor,
            scaffoldBackgroundColor: bgColor,
            fontFamily: 'Ubuntu'));
  }
}
