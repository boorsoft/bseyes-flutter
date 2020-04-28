import 'package:flutter/material.dart';
import '../models/subject_model.dart';
import '../models/teacher_model.dart';
import '../models/question_model.dart';
import '../services/questions_service.dart';

class PollsFutureBuilder extends StatelessWidget {
  final QuestionsService questionsService = QuestionsService();

  List<Question> questions;
  final Teacher teacher;
  final Subject subject;

  PollsFutureBuilder({this.teacher, this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: questionsService.getQuestions(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
              if (snapshot.hasData) {
                questions = snapshot.data;
                return Poll(
                    subject: subject, teacher: teacher, questions: questions);
              } else if (snapshot.hasError) {
                // Если возникла ошибка
                return Center(
                  child: Text('Не удалось загрузить данные...'),
                );
              } else {
                // Если данные еще не загрузились
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    SizedBox(height: 30.0),
                    Center(child: Text('Идёт загрузка данных...'))
                  ],
                );
              }
            }));
  }
}

class Poll extends StatefulWidget {
  final Subject subject;
  final Teacher teacher;
  final List<Question> questions;

  Poll({this.subject, this.teacher, this.questions});

  @override
  PollState createState() => PollState();
}

class PollState extends State<Poll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Text(widget.subject.subName + " " + widget.teacher.firstName)));
  }
}
