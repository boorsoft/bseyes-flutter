import 'package:flutter/material.dart';
import 'views/login.dart';
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
        home: LoginFutureBuilder(),
        theme: ThemeData(
            primaryColor: primaryColor, backgroundColor: Colors.white));
  }
}
