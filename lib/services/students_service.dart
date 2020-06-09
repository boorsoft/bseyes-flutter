import 'dart:convert';

import 'package:bseyes/models/student_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../models/student_model.dart';

class StudentsService {
  final String studentsUrl =
      "http://bseyes-restapi.akmatoff.repl.co/api/students";

  final String token = DotEnv().env['TOKEN'];

  Future<List<Student>> getStudents() async {
    Response res = await get(studentsUrl, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Token $token"
    });

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(res.bodyBytes));

      List<Student> students =
          body.map((dynamic item) => Student.fromJson(item)).toList();

      return students;
    } else {
      throw "Не удалось загрузить данные...";
    }
  }
}
