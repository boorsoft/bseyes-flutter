import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/question_model.dart';

class QuestionsService {
  final String questionsUrl =
      "https://bseyes-restapi.boorsoft.repl.co/api/questions";

  Future<List<Question>> getQuestions() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("TOKEN");

    Response res = await get(questionsUrl, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": token
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
