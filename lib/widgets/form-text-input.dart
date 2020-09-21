import 'package:flutter/material.dart';

import '../style.dart';

Widget formTextInput(String labelText, TextEditingController controller,
    BuildContext context, bool obscureText) {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
      child: TextFormField(
          controller: controller,
          validator: (input) => input == '' ? 'Это обязательное поле' : null,
          obscureText: obscureText,
          style: TextStyle(color: brightTextColor),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: splashColor)),
            labelStyle: TextStyle(color: splashColor),
            labelText: labelText,
          )));
}
