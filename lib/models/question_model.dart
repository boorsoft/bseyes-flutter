import 'package:flutter/foundation.dart';

class Question {
  final int questionID;
  final String question;

  Question({@required this.questionID, @required this.question});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        questionID: json['question_id'] as int,
        question: json['question_body'] as String);
  }
}
