import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

    print(subjectsResponse.body);

    setState(() {
      subjects = json.decode(utf8.decode(subjectsResponse.bodyBytes));
      teachers = json.decode(utf8.decode(teachersResponse.bodyBytes));
    });

    return "OK!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 60.0,
                  child: Center(
                    child: Text(subjects[index]['sub_name']),
                  ));
            }));
  }
}
