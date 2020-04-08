import 'package:flutter/material.dart';
import 'views/home.dart';

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
            primaryColor: Colors.limeAccent, backgroundColor: Colors.white));
  }
}
