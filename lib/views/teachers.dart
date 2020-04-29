import 'package:bseyes_flutter/style.dart';
import 'package:flutter/material.dart';
import 'package:bseyes_flutter/models/subject_model.dart';
import 'package:bseyes_flutter/models/teacher_model.dart';
import 'package:bseyes_flutter/services/teachers_service.dart';
import 'poll.dart';

class TeachersFutureBuilder extends StatelessWidget {
  // Объект класса сервиса преподавателей
  final TeachersService teachersService = TeachersService();

  final Subject subject;
  List<Teacher> teachers;

  // Конструктор для получения предмета с subjects.dart
  TeachersFutureBuilder({this.subject});

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
                return Teachers(subject: subject, teachers: teachers);
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
        body: Column(
      children: <Widget>[
        Stack(children: <Widget>[
          Container(
            height: 200.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg2.jpg"),
                    fit: BoxFit.cover)),
          ),
          Container(
            height: 200.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.6)
                ],
                    stops: [
                  0.0,
                  0.7
                ])),
          ),
          Container(
              alignment: Alignment.center,
              height: 200.0,
              child: Center(
                  child: Text(
                widget.subject.subName,
                style: bgTextStyle,
                textAlign: TextAlign.center,
              )))
        ]),
        Expanded(
            child: Container(
                transform: Matrix4.translationValues(
                    0, -20.0, 0), // Поднимаем контейнер выше
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0)),
                    child: Container(
                        color: Colors.white,
                        // Эта штука работает типа как for
                        child: ListView.builder(
                            itemCount: subTeachers.length,
                            itemBuilder: (BuildContext context, int i) {
                              // строим контекст и создаем переменную i для обозначения индексов элементов
                              return ListTile(
                                  title: Text(
                                    subTeachers[i].firstName +
                                        " " +
                                        subTeachers[i].middleName,
                                    style: defaultTextStyle,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 7.0, horizontal: 30.0),
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PollsFutureBuilder(
                                                subject: widget.subject,
                                                teacher: subTeachers[i],
                                              ))));
                            })))))
      ],
    ));
  }
}
