import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.orange,
  appBarTheme: AppBarTheme(
    color: Colors.black,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white70),
  ),
);
