import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:core';

import 'package:bseyes_flutter/style.dart';
import '../models/subject_model.dart';
import '../models/teacher_model.dart';
import '../models/answer_model.dart';
import '../services/answers_service.dart';

class PollFinish extends StatefulWidget {
  final Subject subject;
  final Teacher teacher;
  final List<int> rates;
  final List questions;

  PollFinish({this.subject, this.teacher, this.rates, this.questions});

  @override
  PollFinishState createState() => PollFinishState();
}

class PollFinishState extends State<PollFinish> {
  TextEditingController commentController = TextEditingController();
  AnswersService answersService = AnswersService();
  Answer answer = Answer();
  var answerJson;
  var ratesJoined;

  @override
  void initState() {
    super.initState();
    ratesJoined = widget.rates.join(",");
    print(widget.rates);
    print(ratesJoined);
  }

  void sendAnswer() {
    answer = Answer(
        teacher: widget.teacher.teacherID,
        subject: widget.subject.subjectID,
        question: widget.questions,
        rate: ratesJoined,
        comment: commentController.text);
    answerJson = jsonEncode(answer.toJson());
    answersService.addAnswer(answerJson);

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('Комментарий')),
        body: Container(
            color: primaryColor,
            child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0))),
                child: Column(
                  children: <Widget>[
                    Container(
                        child: TextField(
                      controller: commentController,
                      maxLength: TextField.noMaxLength,
                      maxLines: 10,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5.0),
                        labelText: 'Напишите комментарий',
                      ),
                    )),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 15.0),
                      child: RaisedButton(
                        onPressed: () => sendAnswer(),
                        splashColor: splashColor,
                        padding: EdgeInsets.all(10.0),
                        color: Colors.black87,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Text('ОТПРАВИТЬ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                letterSpacing: 3.5)),
                      ),
                    )
                  ],
                ))));
  }
}
