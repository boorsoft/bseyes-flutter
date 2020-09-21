import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bseyes/style.dart';
import 'package:bseyes/screens/teachers.dart';
import 'login.dart';
import '../models/student_model.dart';

class Subjects extends StatefulWidget {
  final Student student;

  Subjects({this.student});

  @override
  SubjectsState createState() => SubjectsState();
}

class SubjectsState extends State<Subjects> {
  SharedPreferences sharedPreferences;

  logOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Предметы',
                        textAlign: TextAlign.center,
                        style: defaultTextStyleWhiteBold),
                    IconButton(
                        icon: FaIcon(FontAwesomeIcons.signOutAlt,
                            color: primaryColor),
                        onPressed: () {
                          logOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Login()));
                        }),
                  ])),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(top: 10.0),
                width: double.infinity,
                // Эта штука работает типа как for
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                      widget.student.subject
                          .length, // количество элементов = размер списка subjects
                      (i) {
                    // строим контекст и создаем переменную i для обозначения индексов элементов
                    return Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Material(
                          color: secondaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          child: InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              splashColor: splashColor,
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TeachersFutureBuilder(
                                              subject:
                                                  widget.student.subject[i]))),
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(20.0),
                                  height: 60.0,
                                  child: Text(widget.student.subject[i].subName,
                                      style: defaultTextStyleWhiteBold))),
                        ));
                  }),
                )),
          ),
        ],
      ),
    ));
  }
}
