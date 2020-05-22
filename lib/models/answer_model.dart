class Answer {
  final int answerID;
  final int teacher;
  final int subject;
  final List question;
  final List rate;

  Answer({this.answerID, this.teacher, this.subject, this.question, this.rate});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
        answerID: json['answer_id'] as int,
        teacher: json['teacher'] as int,
        subject: json['subject'] as int,
        question: json['question'] as List,
        rate: json['rate'] as List);
  }

  Map<String, dynamic> toJson() => {
        'answer_id': answerID,
        'teacher': teacher,
        'subject': subject,
        'question': question,
        'rate': rate
      };
}
