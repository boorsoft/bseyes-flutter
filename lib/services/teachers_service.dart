import 'dart:convert';

import 'package:bseyes/models/teacher_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/teacher_model.dart';

class TeachersService {
  final String teachersUrl =
      "https://bseyes-restapi.boorsoft.repl.co/api/teachers";

  Future<List<Teacher>> getTeachers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("TOKEN");

    Response res = await get(teachersUrl, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": token
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
