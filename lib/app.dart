import 'package:flutter/material.dart';
import 'views/home.dart';
import 'views/subjects.dart';
import 'style.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        theme: ThemeData(
            primaryColor: primaryColor, backgroundColor: Colors.white));
  }
}
