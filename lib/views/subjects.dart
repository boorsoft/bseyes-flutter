import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:bseyes/models/subject_model.dart';
import 'package:bseyes/services/subjects_service.dart';
import 'package:bseyes/style.dart';
import 'package:bseyes/views/teachers.dart';
import 'login.dart';
import '../models/student_model.dart';

class SubjectsFutureBuilder extends StatefulWidget {
  final Student student;

  SubjectsFutureBuilder({this.student});

  @override
  _SubjectsFutureBuilderState createState() => _SubjectsFutureBuilderState();
}

class _SubjectsFutureBuilderState extends State<SubjectsFutureBuilder> {
  final SubjectsService subjectsService = SubjectsService();
  List<Subject> subjects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            // FutureBuilder - штука которая из Future функции строит контекст
            future: subjectsService
                .getSubjects(), // Из объекта класса subjectsService вызываем Future функцию getSubjects(), которая возвращает список
            builder:
                (BuildContext context, AsyncSnapshot<List<Subject>> snapshot) {
              // snapshot - типа есть данные
              if (snapshot.hasData) {
                // Если в снапшоте есть данные
                subjects = snapshot
                    .data; // Создаем список и присваиваем данные snapshot
                return Subjects(student: widget.student);
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
                    SizedBox(height: 30.0),
                    Center(child: Text('Идёт загрузка данных...'))
                  ],
                );
              }
            }));
  }
}

class Subjects extends StatefulWidget {
  final Student student;

  Subjects({this.student});

  @override
  SubjectsState createState() => SubjectsState();
}

class SubjectsState extends State<Subjects> {
  SharedPreferences sharedPreferences;
  // List<Subject> studentSubjects = [];

  @override
  void initState() {
    super.initState();
    // sortSubjects();
  }

  // Функция для сортировки предметов по студентам
  // List<Subject> sortSubjects() {
  //   for (int i = 0; i < widget.subjects.length; i++) {
  //     if (widget.student.subject.contains(widget.subjects[i].subjectID)) {
  //       studentSubjects.add(widget.subjects[i]);
  //     }
  //   }
  //   return studentSubjects;
  // }

  logOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Предметы', style: headerTextStyle),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  logOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login()),
                      (Route<dynamic> route) => false);
                },
                child: FaIcon(
                  FontAwesomeIcons.signOutAlt,
                  color: Colors.white,
                  size: 22.0,
                ))
          ],
        ),
        body: Container(
          color: primaryColor,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0)),
                      child: Container(
                          padding: EdgeInsets.only(top: 10.0),
                          color: Colors.white,
                          width: double.infinity,
                          // Эта штука работает типа как for
                          child: ListView.builder(
                              itemCount: widget.student.subject
                                  .length, // количество элементов = размер списка subjects
                              itemBuilder: (BuildContext context, int i) {
                                // строим контекст и создаем переменную i для обозначения индексов элементов
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 4.2,
                                                  color: Colors.black54
                                                      .withOpacity(0.4),
                                                  offset: Offset(1.5, 2.6))
                                            ]),
                                        child: Material(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                          child: InkWell(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              splashColor: splashColor,
                                              onTap: () => Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) => TeachersFutureBuilder(
                                                          subject: widget
                                                              .student
                                                              .subject[i]))),
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  height: 150.0,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        FaIcon(
                                                            FontAwesomeIcons
                                                                .bars,
                                                            size: 20.0,
                                                            color: Color(
                                                                0xFFB2B2B2)),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            widget
                                                                .student
                                                                .subject[i]
                                                                .subName,
                                                            style:
                                                                defaultTextStyleWhiteBold)
                                                      ]))),
                                        )));
                              }))))
            ],
          ),
        ));
  }
}
