class Answer {
  final int answerID;
  final int teacher;
  final int subject;
  final List question;
  final String rate;
  final String comment;

  Answer({this.answerID, this.teacher, this.subject, this.question, this.rate, this.comment});

  Map<String, dynamic> toJson() => {
        'answer_id': answerID,
        'teacher': teacher,
        'subject': subject,
        'question': question,
        'rate': rate,
        'comment': comment
      };
}
