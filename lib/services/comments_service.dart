import 'package:http/http.dart';

class CommentsService {
  final String commentsURL =
      'http://bseyes-restapi--akmatoff.repl.co/api/comments/';

  Future<void> addComment(var comment) async {
    Response res = await post(commentsURL, body: comment, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Token 2dd6595ae58c373ee94a855469e63c391bb64adf"
    });

    if (res.statusCode == 200) {
      print("Posted!");
      print(comment);
    } else {
      throw 'Ошибка при отправлении!';
    }
  }
}
