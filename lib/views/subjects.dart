import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bseyes_flutter/models/subject_model.dart';
import 'package:bseyes_flutter/services/subjects_service.dart';
import 'package:bseyes_flutter/style.dart';
import 'package:bseyes_flutter/views/teachers.dart';
import 'login.dart';
import '../models/student_model.dart';

class SubjectsFutureBuilder extends StatelessWidget {
  final SubjectsService subjectsService =
      SubjectsService(); // Создаем новый объект класса SubjectsService

  final Student student;
  List<Subject> subjects;

  SubjectsFutureBuilder({this.student});

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
                return Subjects(subjects: subjects, student: student);
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
  final List<Subject> subjects;
  final Student student;

  Subjects({this.subjects, this.student});

  @override
  SubjectsState createState() => SubjectsState();
}

class SubjectsState extends State<Subjects> {
  SharedPreferences sharedPreferences;
  List<Subject> studentSubjects = [];

  @override
  void initState() {
    super.initState();
    sortSubjects();
  }

  // Функция для сортировки предметов по студентам
  List<Subject> sortSubjects() {
    for (int i = 0; i < widget.subjects.length; i++) {
      if (widget.student.subject.contains(widget.subjects[i].subjectID)) {
        studentSubjects.add(widget.subjects[i]);
      }
    }
    return studentSubjects;
  }

  logOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    sharedPreferences.commit();
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
                        builder: (BuildContext context) =>
                            LoginFutureBuilder()),
                    (Route<dynamic> route) => false);
              },
              child: Text('ВЫЙТИ',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.2,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'San Francisco')),
            )
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
                          color: Colors.white,
                          width: double.infinity,
                          // Эта штука работает типа как for
                          child: ListView.builder(
                              itemCount: studentSubjects
                                  .length, // количество элементов = размер списка subjects
                              itemBuilder: (BuildContext context, int i) {
                                // строим контекст и создаем переменную i для обозначения индексов элементов
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 12.0),
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
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                          child: InkWell(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              splashColor: Colors.white12,
                                              onTap: () => Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          TeachersFutureBuilder(
                                                              subject:
                                                                  studentSubjects[
                                                                      i]))),
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  height: 150.0,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(Icons.subject,
                                                            color: Color(
                                                                0xFFB2B2B2)),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            studentSubjects[i]
                                                                .subName,
                                                            style:
                                                                defaultTextStyleBold)
                                                      ]))),
                                        )));
                                // return ListTile(
                                //     title: Text(
                                //       subjects[i].subName,
                                //       style: defaultTextStyle,
                                //       textAlign: TextAlign.center,
                                //     ),
                                //     contentPadding:
                                //         EdgeInsets.symmetric(
                                //             vertical: 7.0,
                                //             horizontal: 10.0),
                                //     onTap: () => Navigator.of(context)
                                //         .push(MaterialPageRoute(
                                //             builder: (context) =>
                                //                 TeachersFutureBuilder(
                                //                   subject: subjects[i],
                                //                 ))));
                              }))))
            ],
          ),
        ));
  }
}
