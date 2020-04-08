import 'package:flutter/material.dart';

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
    color: Colors.black,
    fontFamily: 'San Francisco',
    fontSize: 17.0,
    fontWeight: FontWeight.normal);
