import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:bseyes_flutter/style.dart';
import '../models/subject_model.dart';
import '../models/teacher_model.dart';
import '../models/comment_model.dart';
import '../services/comments_service.dart';

class PollFinish extends StatefulWidget {
  final Subject subject;
  final Teacher teacher;

  PollFinish({this.subject, this.teacher});

  @override
  PollFinishState createState() => PollFinishState();
}

class PollFinishState extends State<PollFinish> {
  TextEditingController commentController = TextEditingController();
  CommentsService commentsService = CommentsService();
  Comment comment = Comment();
  var commentJson;

  @override
  void initState() {
    super.initState();
  }

  void sendComment() {
    if (commentController.text != '') {
      comment = Comment(
          comment: commentController.text,
          teacher: widget.teacher.teacherID,
          subject: widget.subject.subjectID);
      commentJson = jsonEncode(comment.toJson());
      commentsService.addComment(commentJson);
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('Комментарий')),
        body: Container(
            color: primaryColor,
            child: Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0)),
                    child: Container(
                        color: Colors.white,
                        child: ListView(
                          padding: EdgeInsets.all(7.0),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 15.0),
                              child: RaisedButton(
                                onPressed: () => sendComment(),
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
                        ))))));
  }
}
