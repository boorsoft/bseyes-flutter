import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class CommentsService {
  final String commentsURL =
      'http://bseyes-restapi--akmatoff.repl.co/api/comments/';

  final String token = DotEnv().env['TOKEN'];

  Future<void> addComment(var comment) async {
    Response res = await post(commentsURL, body: comment, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Token $token"
    });

    if (res.statusCode == 201) {
      print("Posted!");
      print(comment);
    } else {
      throw res.statusCode;
    }
  }
}
