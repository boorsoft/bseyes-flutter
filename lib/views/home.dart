import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../style.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String subjectsUrl = "https://bseyes-restapi--akmatoff.repl.co/api/subjects";
  String teachersUrl = "https://bseyes-restapi--akmatoff.repl.co/api/teachers";
  List subjects;
  List teachers;

  @override
  void initState() {
    super.initState();
    this.getSubjects();
  }

  Future<String> getSubjects() async {
    var subjectsResponse = await http.get(Uri.encodeFull(subjectsUrl),
        headers: {"Accept": "application/json"});

    var teachersResponse = await http.get(Uri.encodeFull(teachersUrl),
        headers: {"Accept": "application/json"});

    setState(() {
      if (subjectsResponse.statusCode == 200) {
        subjects = json.decode(utf8.decode(subjectsResponse.bodyBytes));
        teachers = json.decode(utf8.decode(teachersResponse.bodyBytes));
      }
    });

    return "OK!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
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
                          style: bgTextStyle, textAlign: TextAlign.center))),
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
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    padding:
                                        EdgeInsets.only(left: 5.0, right: 5.0),
                                    height: 70.0,
                                    child: Center(
                                      child: Text(
                                        subjects[index]['sub_name'],
                                        style: defaultTextStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ));
                              }),
                        )))),
          ],
        ));
  }
}
