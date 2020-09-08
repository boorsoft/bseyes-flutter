import 'dart:convert';
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
  String apiUrl = "bseyes-restapi.akmatoff.repl.co/login";

  final formKey = GlobalKey<FormState>();
  bool wrongUser = false;

  // Send username and password to the server
  Future<Map<String, dynamic>> login(String username, String password) async {
    Response res = await post(apiUrl, body: {
      'username': username,
      'password': password
    }, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });

    if (res.statusCode == 200) {
      print('authorized!');
      Map<String, dynamic> data = jsonDecode(res.body);
      return data;
    } else if (res.statusCode == 400) {
      print('Wrong username or password');
    } else {
      print('unexpected error');
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                Text(
                                  'Логин',
                                  style: defaultTextStyleBold,
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                    child: TextFormField(
                                        controller: usernameController,
                                        validator: (input) => input == ''
                                            ? 'Это обязательное поле'
                                            : null,
                                        decoration: InputDecoration(
                                            labelText: 'Введите логин...',
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    style: BorderStyle.solid,
                                                    width: 2.0)),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    style: BorderStyle.solid,
                                                    width: 2.0)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid,
                                                    width: 2.0)))))
                              ]),
                          SizedBox(height: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Пароль',
                                style: defaultTextStyleBold,
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                  child: TextFormField(
                                      controller: passwordController,
                                      validator: (input) => input == ''
                                          ? 'Это обязательное поле'
                                          : null,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          labelText: 'Введите пароль...',
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  style: BorderStyle.solid,
                                                  width: 2.0)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red,
                                                  style: BorderStyle.solid,
                                                  width: 2.0)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black87,
                                                  style: BorderStyle.solid,
                                                  width: 2.0)))))
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

                                var res = await login(username, password);

                                if (res != null &&
                                    username != '' &&
                                    password != '') {
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  sharedPreferences.setString(
                                      "student_data", jsonEncode(res));
                                  Student student = Student(
                                      studentID: res['student_id'],
                                      subject: res['subject'],
                                      username: res['usernmae']);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Subjects(
                                                student: student,
                                                subjects: res['subject'],
                                              )));
                                } else {
                                  alertDialog('Ошибка при авторизации',
                                      'Неверный логин или пароль', context);
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
