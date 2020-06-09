import 'dart:convert';

import 'package:bseyes/models/teacher_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../models/teacher_model.dart';

class TeachersService {
  final String teachersUrl =
      "https://bseyes-restapi--akmatoff.repl.co/api/teachers";

  final String token = DotEnv().env['TOKEN'];

  Future<List<Teacher>> getTeachers() async {
    Response res = await get(teachersUrl, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Token $token"
    });

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(res.bodyBytes));

      List<Teacher> teachers =
          body.map((dynamic item) => Teacher.fromJson(item)).toList();

      return teachers;
    } else {
      throw "Не удалось загрузить данные...";
    }
  }
}
