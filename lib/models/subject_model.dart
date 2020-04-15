import 'package:flutter/foundation.dart';

class Subject {
  final int subjectID;
  final String subName;

  Subject(
      {@required
          this.subjectID,
      @required
          this.subName}); // Создаем конструктор класса Subject, required - обязательный аргумент

  // Переводим JSON в Dart класс, описываем функцию которая делает это
  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
        subjectID: json['subject_id']
            as int, // Значением аргумента ставим значение с JSON, в квадратных скобках вводим ключ JSON. as int - то есть это число
        subName: json['sub_name']
            as String); // as String - потому что sub_name - это строка
  }
}
