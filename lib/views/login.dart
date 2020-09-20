import 'dart:convert';
import 'package:bseyes/models/subject_model.dart';
import 'package:bseyes/widgets/form-text-input.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
                constraints: BoxConstraints(minHeight: 300.0, maxHeight: 450.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: Text(
                      'Авторизация',
                      style: headingTextStyle,
                    )),
                    SizedBox(height: 20.0),
                    Form(
                        key: formKey,
                        child: Column(children: <Widget>[
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                formTextInput('Введите логин...',
                                    usernameController, context)
                              ]),
                          SizedBox(height: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              formTextInput('Введите пароль...',
                                  passwordController, context)
                            ],
                          ),
                          SizedBox(height: 15.0),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 15.0),
                            child: RaisedButton(
                              onPressed: () async {
                                String username = usernameController.text
                                    .trim()
                                    .toLowerCase();
                                String password =
                                    passwordController.text.trim();

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
                                    Student student = Student(
                                        studentID: res['student_id'],
                                        subject: res['subject'],
                                        username: res['username']);
                                    print('Subjects' + res['subject']);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Subjects(student: student)));
                                  } else {
                                    alertDialog('Ошибка при авторизации',
                                        'Неверный логин или пароль', context);
                                  }
                                }
                              },
                              padding: EdgeInsets.all(10.0),
                              color: Colors.black87,
                              splashColor: splashColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Text('ВОЙТИ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      letterSpacing: 3.5)),
                            ),
                          )
                        ])),
                  ],
                ))));
  }
}
