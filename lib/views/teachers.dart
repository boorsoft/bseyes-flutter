import 'package:bseyes_flutter/models/subject_model.dart';
import 'package:flutter/material.dart';

class Teachers extends StatelessWidget {
  final Subject subject;

  Teachers({@required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(subject.subName)));
  }
}
