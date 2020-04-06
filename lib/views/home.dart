import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future fetchSubjects(http.Client client) async {
  final response =
      await client.get('http://bseyes-restapi--akmatoff.repl.co/api/teachers');

  return response.body;
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List subjects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: fetchSubjects(http.Client()),
            builder: (context, snapshot) {
              subjects = json.decode(snapshot.data.toString());
              print(subjects[0]['first_name']);
              if (snapshot.hasData) {
                return Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/bg.jpg"),
                              fit: BoxFit.cover)),
                    ),
                    Center(
                      child: Container(
                          margin: EdgeInsets.only(left: 60.0, right: 60.0),
                          height: 350.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text(subjects[0]['first_name'],
                              style: TextStyle(fontSize: 20.0))),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
