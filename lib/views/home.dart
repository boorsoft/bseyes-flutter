import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../style.dart';
import 'teachers.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String subjectsUrl = "https://bseyes-restapi--akmatoff.repl.co/api/subjects";
  List subjects;

  @override
  void initState() {
    super.initState();
    this.getSubjects();
  }

  Future<String> getSubjects() async {
    var subjectsResponse = await http.get(Uri.encodeFull(subjectsUrl),
        headers: {"Accept": "application/json"});

    setState(() {
      if (subjectsResponse.statusCode == 200) {
        subjects = json.decode(utf8.decode(subjectsResponse.bodyBytes));
      }
    });

    return "OK!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: getSubjects(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    Stack(children: <Widget>[
                      Container(
                          height: 200.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/bg.jpg"),
                                  fit: BoxFit.cover))),
                      Container(
                          alignment: Alignment.center,
                          height: 200.0,
                          child: Center(
                              child: Text("ВЫБЕРИТЕ ПРЕДМЕТ",
                                  style: bgTextStyle,
                                  textAlign: TextAlign.center))),
                    ]),
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
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                            onTap: () => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        Teachers(
                                                          subjectID:
                                                              subjects[index]
                                                                  ['sub_id'],
                                                        ))),
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 15.0),
                                                height: 60.0,
                                                child: Center(
                                                    child: Text(
                                                        subjects[index]
                                                            ['sub_name'],
                                                        style:
                                                            defaultTextStyle))));
                                      }),
                                )))),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Не удалось загрузить данные...'));
              } else {
                return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                      Center(child: CircularProgressIndicator()),
                      SizedBox(height: 30.0),
                      Center(child: Text('Идёт загрузка данных...'))
                    ]));
              }
            }));
  }
}
