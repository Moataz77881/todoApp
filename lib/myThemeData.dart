import 'dart:ui';
import 'package:flutter/material.dart';

class myThemeData {
  static const Color lightScaffoldBackground =
      Color.fromARGB(255, 223, 236, 219);

  static final ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: lightScaffoldBackground,
      textTheme: TextTheme(
        headline1: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
        subtitle1: TextStyle(fontSize: 16, color: Colors.grey),
        headline2: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
      ));
}
