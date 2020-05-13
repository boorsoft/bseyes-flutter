class Comment {
  final int commentID;
  final int teacher;
  final int subject;
  final String comment;

  Comment({this.commentID, this.teacher, this.subject, this.comment});

  Map<String, dynamic> toJson() => {
        'comment_id': commentID,
        'teacher': teacher,
        'subject': subject,
        'comment': comment
      };
}
