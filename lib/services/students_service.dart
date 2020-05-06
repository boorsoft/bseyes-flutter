import 'dart:convert';

import 'package:bseyes_flutter/models/student_model.dart';
import 'package:http/http.dart';

import '../models/student_model.dart';

class StudentsService {
  final String studentsUrl =
      "http://bseyes-restapi.akmatoff.repl.co/api/students";

  Future<List<Student>> getStudents() async {
    Response res = await get(studentsUrl, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Token 2dd6595ae58c373ee94a855469e63c391bb64adf"
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
