import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(App());
}
