import 'subject_model.dart';
import 'teacher_model.dart';

class Comment {
  final int commentID;
  final Teacher teacher;
  final Subject subject;
  final String comment;

  Comment({this.commentID, this.teacher, this.subject, this.comment});

  Map<String, dynamic> toJson() =>
      {'teacher': teacher, 'subject': subject, 'comment': comment};
}
