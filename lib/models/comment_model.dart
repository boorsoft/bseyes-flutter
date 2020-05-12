import 'package:flutter/foundation.dart';

import 'subject_model.dart';
import 'teacher_model.dart';

class Comment {
  final int commentID;
  final Teacher teacher;
  final Subject subject;
  final String comment;

  Comment(
      {@required this.commentID,
      @required this.teacher,
      @required this.subject,
      @required this.comment});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        commentID: json['comment_id'] as int,
        teacher: json['teacher'] as Teacher,
        subject: json['subject'] as Subject,
        comment: json['comment'] as String);
  }
}
