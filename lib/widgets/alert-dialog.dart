import 'package:flutter/material.dart';
import 'package:bseyes/style.dart';

void alertDialog(String title, String text, BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            FlatButton(
                child: Text('ОК', style: defaultTextStyleBold),
                onPressed: () => Navigator.pop(context))
          ],
        );
      });
}
