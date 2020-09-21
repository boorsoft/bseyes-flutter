import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnswersService {
  final String answersURL =
      "https://bseyes-restapi.boorsoft.repl.co/api/answers";

  Future<void> addAnswer(var answer) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("TOKEN");

    Response res = await post(answersURL,
        body: answer,
        headers: {"Content-Type": "application/json", "Authorization": token});

    if (res.statusCode == 201) {
      print("Posted!");
      print(answer);
    } else {
      throw res.statusCode;
    }
  }
}
