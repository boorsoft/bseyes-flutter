import 'dart:convert';

import 'package:bseyes/models/subject_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class SubjectsService {
  final String subjectsUrl =
      "https://bseyes-restapi--akmatoff.repl.co/api/subjects"; // Ссылка на API, на страницу subjects

  final String token = DotEnv().env['TOKEN'];

  Future<List<Subject>> getSubjects() async {
    // Описываем функцию, async должен быть потому что типа не может сразу выполняться, надо подождать
    Response res = await get(
        // await здесь обязателен, типа нужно дождаться ответа
        subjectsUrl,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Token $token"
        }); // В переменную res с типом данных Response (т.е ответ) вводим функцию get, он по URL выполняет запрос

    // Если успешно получили ответ
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(res
          .bodyBytes)); // Создаем список body, и берем JSON с HTTP запроса. Dynamic - список из динамичных элементов

      List<Subject> subjects = body
          .map((dynamic item) => Subject.fromJson(item))
          .toList(); // Body, который получаем с запроса переводим в Map (типа словаря в питоне), и превращаем это в список

      return subjects; // Эта функция возвращает список subjects
    } else {
      throw "Не удалось загрузить данные"; // Если статус код любой другой
    }
  }
}
