import 'package:flutter/material.dart';

import 'package:bseyes/models/subject_model.dart';
import 'package:bseyes/models/teacher_model.dart';
import 'package:bseyes/style.dart';
import 'package:bseyes/services/teachers_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                  child: Text('Не удалось загрузить данные...',
                      style: defaultTextStyleWhiteBold),
                );
              } else {
                // Если данные еще не загрузились
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    SizedBox(height: 30.0),
                    Center(
                        child: Text('Идёт загрузка данных...',
                            style: defaultTextStyleWhiteBold))
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
                height: 60.0,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.arrowLeft,
                            color: primaryColor),
                        iconSize: 18.0,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text('Преподаватели',
                          textAlign: TextAlign.center,
                          style: defaultTextStyleWhiteBold),
                    ])),
            Expanded(
                child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(subTeachers.length, (i) {
                return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
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
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PollsFutureBuilder(
                                            subject: widget.subject,
                                            teacher: subTeachers[i],
                                          ))),
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 60.0,
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                      subTeachers[i].firstName +
                                          " " +
                                          subTeachers[i].middleName,
                                      style: defaultTextStyleWhiteBold)))),
                    ));
              }),
            ))
          ],
        ),
      ),
    );
  }
}
