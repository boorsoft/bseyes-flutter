import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:core';

import 'package:bseyes/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
                height: 60.0,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.arrowLeft,
                            color: primaryColor),
                        iconSize: 18.0,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text('Комментарий',
                          textAlign: TextAlign.center,
                          style: defaultTextStyleWhiteBold),
                    ])),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: TextField(
                    style: defaultTextStyle,
                    controller: commentController,
                    maxLength: TextField.noMaxLength,
                    maxLines: 10,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5.0),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 2.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 2.0))),
                  )),
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 15.0),
                    child: RaisedButton(
                      onPressed: () => sendAnswer(),
                      splashColor: splashColor,
                      padding: EdgeInsets.all(10.0),
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Text('ОТПРАВИТЬ',
                          style: TextStyle(
                              color: defaultTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              letterSpacing: 3.5)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
