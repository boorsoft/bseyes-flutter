import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  fetchData() async {
    final response =
        await http.get("https://bseyes-restapi--akmatoff.repl.co/api/teachers");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
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
                color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
          ),
        ),
      ],
    ));
  }
}
