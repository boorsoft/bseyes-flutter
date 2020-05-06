import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bseyes_flutter/services/students_service.dart';
import 'package:bseyes_flutter/style.dart';
import 'subjects.dart';
import '../models/student_model.dart';

class LoginFutureBuilder extends StatelessWidget {
  final StudentsService studentsService = StudentsService();

  List<Student> students;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: studentsService.getStudents(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
              if (snapshot.hasData) {
                students = snapshot.data;
                return Login(students: students);
              } else if (snapshot.hasError) {
                // Если возникла ошибка
                return Center(
                  child: Text('Не удалось загрузить данные...'),
                );
              } else {
                // Если данные еще не загрузились
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              }
            }));
  }
}

class Login extends StatefulWidget {
  final List<Student> students;

  Login({this.students});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool wrongUser = false;

  @override
  void initState() {
    super.initState();
  }

  logIn(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (formKey.currentState.validate()) {
      for (int i = 0; i < widget.students.length; i++) {
        if (widget.students[i].username == username &&
            widget.students[i].password == password) {
          formKey.currentState.save();
          sharedPreferences.setBool("logged_in", true);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => Subjects()));
          setState(() {
            wrongUser = false;
          });
          break;
        } else {
          setState(() {
            wrongUser = true;
          });
        }
      }
    }
  }

  Widget errorMessage() {
    if (wrongUser) {
      return Center(
          child: Container(
              child: Text('Неверный логин или пароль!',
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'San Francisco',
                      fontSize: 14.0))));
    } else {
      return SizedBox();
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
                          errorMessage(),
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
