import 'dart:convert';

import 'package:http/http.dart';

import 'models/subject_model.dart';

class HttpService {
  final String subjectsUrl =
      "https://bseyes-restapi--akmatoff.repl.co/api/subjects";

  Future<List<Subject>> getSubjects() async {
    Response res = await get(subjectsUrl);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(res.bodyBytes));

      List<Subject> subjects =
          body.map((dynamic item) => Subject.fromJson(item)).toList();

      return subjects;
    } else {
      throw "Не удалось загрузить данные";
    }
  }
}
