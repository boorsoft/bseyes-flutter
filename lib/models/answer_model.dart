class Answer {
  final int answerID;
  final int teacher;
  final int subject;
  final List question;
  final List rate;

  Answer({this.answerID, this.teacher, this.subject, this.question, this.rate});

  Map<String, dynamic> toJson() => {
        'answer_id': answerID,
        'teacher': teacher,
        'subject': subject,
        'question': question,
        'rate': rate
      };
}
