import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:bseyes/models/subject_model.dart';
import 'package:bseyes/widgets/form-text-input.dart';
import 'package:bseyes/widgets/widgets.dart';
import 'package:bseyes/style.dart';
import 'subjects.dart';
import '../models/student_model.dart';

class Login extends StatefulWidget {
  final List<Student> students;

  Login({this.students});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String apiUrl = "https://bseyes-restapi.boorsoft.repl.co/login/";

  final formKey = GlobalKey<FormState>();
  bool wrongUser = false;
  double formMaxHeight = 370.0;

  // Send username and password to the server
  Future<Map<String, dynamic>> login(String username, String password) async {
    Map<String, dynamic> userCredentials = {
      "username": username,
      "password": password
    };

    Response res = await post(apiUrl,
        body: jsonEncode(userCredentials),
        headers: {'Content-Type': 'application/json'});

    if (res.statusCode == 200) {
      print('authorized!');
      Map<String, dynamic> data = jsonDecode(utf8.decode(res.bodyBytes));
      return data;
    } else if (res.statusCode == 400) {
      print('Wrong username or password');
    } else {
      print('unexpected error');
      print(res.statusCode);
    }

    return null;
  }

  @override
  void didChangeDependencies() {
    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
      setState(() {
        // Change max height of form if keyboard is open or closed
        if (visible)
          formMaxHeight = 553.1;
        else
          formMaxHeight = 370.0;
      });

      print('Visible: $visible');
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/LoginScreenUI.png'),
                      fit: BoxFit.fill)),
            ),
            Center(
                heightFactor: 9.0,
                child: Text('Глазами Студента',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: defaultTextColor,
                    )))
          ],
        )),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
            constraints:
                BoxConstraints(minHeight: 200.0, maxHeight: formMaxHeight),
            decoration: BoxDecoration(color: primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                    key: formKey,
                    child: Column(children: <Widget>[
                      Text('Вход', style: defaultTextStyleWhiteBold),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Icon(Icons.account_circle,
                                size: 30.0, color: bgColor),
                          ),
                          SizedBox(width: 5.0),
                          Expanded(
                            child: formTextInput(
                                'Логин', usernameController, context, false),
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Icon(Icons.lock_outline,
                                size: 30.0, color: bgColor),
                          ),
                          SizedBox(width: 5.0),
                          Expanded(
                            child: formTextInput(
                                'Пароль', passwordController, context, true),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 15.0),
                        child: RaisedButton(
                          onPressed: () async {
                            String username =
                                usernameController.text.trim().toLowerCase();
                            String password = passwordController.text.trim();

                            if (formKey.currentState.validate()) {
                              var res = await login(username, password);

                              formKey.currentState.save();
                              if (res != null &&
                                  username != '' &&
                                  password != '') {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.setString(
                                    "student_data", jsonEncode(res));
                                sharedPreferences.setString(
                                    "TOKEN", res['token']);
                                List<dynamic> subjects = res['subject']
                                    .map((dynamic item) =>
                                        Subject.fromJson(item))
                                    .toList();
                                Student student = Student(
                                    studentID: res['student_id'],
                                    subject: subjects,
                                    username: res['username']);

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Subjects(
                                              student: student,
                                            )));
                              } else {
                                alertDialog('Ошибка при авторизации',
                                    'Неверный логин или пароль', context);
                              }
                            }
                          },
                          padding: EdgeInsets.all(5.0),
                          color: bgColor,
                          splashColor: splashColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Text('ВОЙТИ',
                              style: TextStyle(
                                  color: defaultTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  letterSpacing: 2.0)),
                        ),
                      )
                    ])),
              ],
            )),
      ],
    ));
  }
}
