import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AnswersService {
  final String answersURL =
      "http://bseyes-restapi--akmatoff.repl.co/api/answers/";

  final String token = DotEnv().env['TOKEN'];

  Future<void> addAnswer(var answer) async {
    Response res = await post(answersURL, body: answer, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Token $token"
    });

    if (res.statusCode == 200) {
      print("Posted!");
      print(answer);
    } else {
      throw res.statusCode;
    }
  }
}
