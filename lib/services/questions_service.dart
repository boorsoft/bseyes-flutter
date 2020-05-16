import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import '../models/question_model.dart';

class QuestionsService {
  final String questionsUrl =
      "http://bseyes-restapi--akmatoff.repl.co/api/questions/";

  final String token = DotEnv().env['TOKEN'];

  Future<List<Question>> getQuestions() async {
    Response res = await get(questionsUrl, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Token $token"
    });

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(res.bodyBytes));

      List<Question> questions =
          body.map((dynamic item) => Question.fromJson(item)).toList();

      return questions;
    } else {
      throw 'Не удалось загрузить данные...';
    }
  }
}
