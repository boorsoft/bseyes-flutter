import 'package:flutter/material.dart';

Widget formTextInput(
    String labelText, TextEditingController controller, BuildContext context) {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
      child: TextFormField(
          controller: controller,
          validator: (input) => input == '' ? 'Это обязательное поле' : null,
          decoration: InputDecoration(
            labelText: labelText,
          )));
}
