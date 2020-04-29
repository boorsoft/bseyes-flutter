import 'package:bseyes_flutter/models/subject_model.dart';
import 'package:bseyes_flutter/services/subjects_service.dart';
import 'package:bseyes_flutter/style.dart';
import 'package:bseyes_flutter/views/teachers.dart';
import 'package:flutter/material.dart';

class Subjects extends StatelessWidget {
  final SubjectsService subjectsService =
      SubjectsService(); // Создаем новый объект класса SubjectsService

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
                List<Subject> subjects = snapshot
                    .data; // Создаем список и присваиваем данные snapshot
                return Column(
                  children: <Widget>[
                    // Картинка сверху с надписем
                    // Элементы в Stack накладываются друг на друга, в отличие от Column
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 200.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/bg.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                            alignment: Alignment.center,
                            height: 200.0,
                            child: Center(
                                child: Text(
                              'Выберите предмет',
                              style: bgTextStyle,
                              textAlign: TextAlign.center,
                            )))
                      ],
                    ),
                    Expanded(
                        child: Container(
                            transform: Matrix4.translationValues(
                                0, -22.0, 0), // Поднимаем контейнер выше
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0)),
                                child: Container(
                                    color: Colors.white,
                                    width: double.infinity,
                                    // Эта штука работает типа как for
                                    child: ListView.builder(
                                        itemCount: subjects
                                            .length, // количество элементов = размер списка subjects
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          // строим контекст и создаем переменную i для обозначения индексов элементов
                                          return ListTile(
                                              title: Text(
                                                subjects[i].subName,
                                                style: defaultTextStyle,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 7.0,
                                                      horizontal: 30.0),
                                              onTap: () => Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          TeachersFutureBuilder(
                                                            subject:
                                                                subjects[i],
                                                          ))));
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
