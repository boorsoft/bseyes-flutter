import 'package:bseyes_flutter/models/subject_model.dart';
import 'package:bseyes_flutter/style.dart';
import 'package:bseyes_flutter/views/teachers.dart';
import 'package:flutter/material.dart';

import '../http_service.dart';

class Subjects extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: httpService.getSubjects(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Subject>> snapshot) {
              if (snapshot.hasData) {
                List<Subject> subjects = snapshot.data;
                return Column(
                  children: <Widget>[
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
                            transform: Matrix4.translationValues(0, -20.0, 0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0)),
                                child: Container(
                                    color: Colors.white,
                                    child: ListView.builder(
                                        itemCount: subjects.length,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          return GestureDetector(
                                              onTap: () => Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          Teachers(
                                                            subject:
                                                                subjects[i],
                                                          ))),
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 15.0),
                                                  height: 60.0,
                                                  child: Center(
                                                    child: Text(
                                                        subjects[i].subName),
                                                  )));
                                        })))))
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Не удалось загрузить данные...'),
                );
              } else {
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
