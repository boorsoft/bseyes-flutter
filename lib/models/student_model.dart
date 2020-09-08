import 'package:flutter/foundation.dart';

class Student {
  final int studentID;
  final String username;
  final List subject;

  Student(
      {@required this.studentID,
      @required this.username,
      @required this.subject});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        studentID: json['student_id'] as int,
        username: json['username'] as String,
        subject: json['subject'] as List);
  }

  Map<String, dynamic> toJson() => {
        'student_id': studentID,
        'username': username,
        'subject': subject.toList()
      };
}
