import 'package:flutter/material.dart';

const primaryColor = Color(0xFF222222);
const splashColor = Color(0xFF555555);
const disabledColor = Color(0xFFE5E5E5);

const bgTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'San Francisco',
    fontSize: 22.0,
    shadows: <Shadow>[
      Shadow(
          color: Color.fromRGBO(0, 0, 0, 0.3),
          blurRadius: 3.0,
          offset: Offset(2.5, 2.5))
    ]);

const defaultTextStyle = TextStyle(
    color: Colors.black87,
    fontFamily: 'San Francisco',
    fontSize: 16.0,
    fontWeight: FontWeight.normal);

const defaultTextStyleBold = TextStyle(
    color: Colors.black87,
    fontFamily: 'San Francisco',
    fontSize: 16.0,
    fontWeight: FontWeight.bold);

const defaultTextStyleWhiteBold = TextStyle(
    color: Colors.white,
    fontFamily: 'San Francisco',
    fontSize: 16.0,
    fontWeight: FontWeight.bold);

const headingTextStyle = TextStyle(
    color: Colors.black87,
    fontFamily: 'San Francisco',
    fontSize: 20.0,
    fontWeight: FontWeight.bold);

const headerTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'San Francisco',
    fontSize: 22.0,
    fontWeight: FontWeight.bold);
