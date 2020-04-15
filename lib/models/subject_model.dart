import 'package:flutter/foundation.dart';

class Subject {
  final int subjectID;
  final String subName;

  Subject({@required this.subjectID, @required this.subName});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
        subjectID: json['subject_id'] as int,
        subName: json['sub_name'] as String);
  }
}
