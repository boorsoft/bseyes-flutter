import 'package:flutter/foundation.dart';

class Teacher {
  final int teacherID;
  final String lastName;
  final String firstName;
  final String middleName;
  final List subject;

  Teacher(
      {@required this.teacherID,
      @required this.lastName,
      @required this.firstName,
      @required this.middleName,
      @required this.subject});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
        teacherID: json['teacher_id'] as int,
        lastName: json['last_name'] as String,
        firstName: json['first_name'] as String,
        middleName: json['middle_name'] as String,
        subject: json['subject'] as List);
  }

  Map<String, dynamic> toJson() => {
        'teacher_id': teacherID,
        'last_name': lastName,
        'first_name': firstName,
        'middle_name': middleName,
        'subject': subject.toList()
      };
}
