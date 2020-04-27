import 'dart:convert';

import 'package:bseyes_flutter/models/teacher_model.dart';
import 'package:http/http.dart';

import '../models/teacher_model.dart';

class TeachersService {
  final String teachersUrl =
      "https://bseyes-restapi--akmatoff.repl.co/api/teachers";

  Future<List<Teacher>> getTeachers() async {
    Response res = await get(teachersUrl);

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
