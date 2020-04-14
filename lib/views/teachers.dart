import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Teachers extends StatefulWidget {
  @override
  State createState() => TeachersState();

  final String subjectID;

  Teachers({this.subjectID});
}

class TeachersState extends State<Teachers> {
  String teachersUrl = "https://bseyes-restapi--akmatoff.repl.co/api/teachers";
  List teachers;

  @override
  void initState() {
    super.initState();
  }

  Future<String> getTeachers() async {
    var response = await http.get(Uri.encodeFull(teachersUrl),
        headers: {"Accept": "application/json"});

    setState(() {
      if (response.statusCode == 200) {
        teachers = json.decode(utf8.decode(response.bodyBytes));
      }
    });

    return 'OK!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: getTeachers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: teachers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          child: Center(
                              child: Text(teachers[index]['first_name'])));
                    });
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
