import 'package:flutter/material.dart';

const primaryColor = Color(0xFF272d33);
const bgColor = Color(0xFFe5e1dd);
const splashColor = Color(0xFFd8d5d2);
const disabledColor = Color(0xFFE5E5E5);
const defaultTextColor = primaryColor;
const brightTextColor = bgColor;

const bgTextStyle =
    TextStyle(color: brightTextColor, fontSize: 22.0, shadows: <Shadow>[
  Shadow(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      blurRadius: 3.0,
      offset: Offset(2.5, 2.5))
]);

const defaultTextStyle = TextStyle(
    color: defaultTextColor, fontSize: 16.0, fontWeight: FontWeight.normal);

const defaultTextStyleBold = TextStyle(
    color: defaultTextColor, fontSize: 16.0, fontWeight: FontWeight.bold);

const defaultTextStyleWhiteBold = TextStyle(
    color: brightTextColor, fontSize: 16.0, fontWeight: FontWeight.bold);

const headingTextStyle = TextStyle(
    color: defaultTextColor, fontSize: 20.0, fontWeight: FontWeight.bold);

const headerTextStyle = TextStyle(
    color: brightTextColor, fontSize: 18.0, fontWeight: FontWeight.bold);
