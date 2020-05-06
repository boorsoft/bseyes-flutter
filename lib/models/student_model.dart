import 'package:flutter/foundation.dart';

class Student {
  final int studentID;
  final String username;
  final String password;
  final List subject;

  Student(
      {@required this.studentID,
      @required this.username,
      @required this.password,
      @required this.subject});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        studentID: json['student_id'] as int,
        username: json['username'] as String,
        password: json['password'] as String,
        subject: json['subject'] as List);
  }
}
