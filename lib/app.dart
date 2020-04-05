import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'views/home.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  fetchData() async {
    final response =
        await http.get("https://bseyes-restapi--akmatoff.repl.co/api/teachers");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        theme: ThemeData(
            primaryColor: Colors.limeAccent, backgroundColor: Colors.white24));
  }
}
