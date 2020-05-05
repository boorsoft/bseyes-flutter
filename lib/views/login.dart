import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bseyes_flutter/style.dart';
import 'subjects.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  logIn(String username, String password) async {
    Map data = {
      "username": username,
      "password": password
    };
    var res = await http.post("https://bseyes-restapi.akmatoff.repl.co/login/", body: data);
    var jsonData;
    if (res.statusCode == 200){
      jsonData = jsonDecode(utf8.decode(res.bodyBytes));
    }
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(username + "," + password);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => Subjects()));
    } else {
      print('Ошибка');
    }
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
                                            ? 'Это поле обязательное'
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
                                          ? 'Это поле обязательное'
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
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 15.0),
                            child: RaisedButton(
                              onPressed: () => logIn(usernameController.text,
                                  passwordController.text),
                              padding: EdgeInsets.all(10.0),
                              color: Colors.black87,
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
