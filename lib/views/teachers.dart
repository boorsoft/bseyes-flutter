import 'package:bseyes_flutter/style.dart';
import 'package:flutter/material.dart';
import 'package:bseyes_flutter/models/subject_model.dart';
import 'package:bseyes_flutter/models/teacher_model.dart';
import 'package:bseyes_flutter/services/teachers_service.dart';

class Teachers extends StatelessWidget {
  final Subject subject;

  Teachers({@required this.subject});

  final TeachersService teachersService = TeachersService();

  List<Teacher> teachers;

  List<Teacher> sortTeachers() {
    for (int i = 0; i < teachers.length; i++) {
      for (int k = 0; k < teachers[i].subject.length; k++) {
        if (teachers[i].subject[k] == subject.subjectID) {}
      }
    }

    return teachers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: teachersService.getTeachers(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Teacher>> snapshot) {
              if (snapshot.hasData) {
                teachers = snapshot.data;
                sortTeachers();
                print(teachers);
                return Column(
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
                            subject.subName,
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
                                        itemCount: teachers.length,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          // строим контекст и создаем переменную i для обозначения индексов элементов
                                          return GestureDetector(
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 15.0),
                                                  height: 60.0,
                                                  child: Center(
                                                    // Выводим название предмета
                                                    child: Text(teachers[i]
                                                            .firstName +
                                                        " " +
                                                        teachers[i].lastName),
                                                  )));
                                        })))))
                  ],
                );
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
