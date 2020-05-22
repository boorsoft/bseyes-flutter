import 'package:bseyes_flutter/style.dart';
import 'package:flutter/material.dart';

import 'package:bseyes_flutter/models/subject_model.dart';
import 'package:bseyes_flutter/models/teacher_model.dart';
import 'package:bseyes_flutter/services/teachers_service.dart';
import 'poll.dart';

class TeachersFutureBuilder extends StatefulWidget {
  // Объект класса сервиса преподавателей
  final Subject subject;

  TeachersFutureBuilder({this.subject});

  @override
  _TeachersFutureBuilderState createState() => _TeachersFutureBuilderState();
}

class _TeachersFutureBuilderState extends State<TeachersFutureBuilder> {
  final TeachersService teachersService = TeachersService();

  List<Teacher> teachers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Получаем данные с сервиса (API)
        body: FutureBuilder(
            future: teachersService.getTeachers(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Teacher>> snapshot) {
              if (snapshot.hasData) {
                teachers = snapshot.data;
                // Возвращаем класс Teachers, где весь UI и передаем данные
                return Teachers(subject: widget.subject, teachers: teachers);
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

class Teachers extends StatefulWidget {
  final Subject subject;
  final List<Teacher> teachers;

  // Конструктор для получения данных с TeachersFutureBuilder
  Teachers({@required this.subject, this.teachers});

  @override
  TeachersState createState() => TeachersState();
}

class TeachersState extends State<Teachers> {
  List<Teacher> subTeachers = [];

  @override
  void initState() {
    super.initState();
    sortTeachers();
  }

  // Функция для сортировки преподавателей по предметам
  List<Teacher> sortTeachers() {
    for (int i = 0; i < widget.teachers.length; i++) {
      if (widget.teachers[i].subject.contains(widget.subject.subjectID)) {
        subTeachers.add(widget.teachers[i]);
      }
    }
    return subTeachers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(widget.subject.subName, style: headerTextStyle)),
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
                          // Эта штука работает типа как for
                          child: ListView.builder(
                              itemCount: subTeachers.length,
                              itemBuilder: (BuildContext context, int i) {
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
                                                      builder: (context) =>
                                                          PollsFutureBuilder(
                                                            subject:
                                                                widget.subject,
                                                            teacher:
                                                                subTeachers[i],
                                                          ))),
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  height: 150.0,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(Icons.person,
                                                            color: Color(
                                                                0xFFB2B2B2)),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            subTeachers[i]
                                                                    .firstName +
                                                                " " +
                                                                subTeachers[i]
                                                                    .middleName,
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
