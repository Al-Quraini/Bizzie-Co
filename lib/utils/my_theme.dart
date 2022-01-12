import 'package:flutter/material.dart';

class MyTheme {
  final Color primary;
  final Color secondary;
  final Color textColor;
  final Color secondTextColor;

  MyTheme(
      {required this.primary,
      required this.secondary,
      required this.textColor,
      required this.secondTextColor});
}

List<MyTheme> myThemes = [
  MyTheme(
    primary: const Color(0xFF162651),
    secondary: const Color(0xFFFFFFFF),
    textColor: const Color(0xFFFFFFFF),
    secondTextColor: const Color(0xFF000000),
  ),
  MyTheme(
    primary: const Color(0xFF00AEEF),
    secondary: const Color(0xFFFFFFFF),
    textColor: const Color(0xFFFFFFFF),
    secondTextColor: const Color(0xff000000),
  ),
  MyTheme(
    primary: const Color(0xFF262626),
    secondary: const Color(0xff000000),
    textColor: const Color(0xFFFFFFFF),
    secondTextColor: const Color(0xFFFFFFFF),
  ),
  MyTheme(
    primary: const Color(0xFFFBC8C8),
    secondary: const Color(0xff41403E),
    textColor: const Color(0xFFFF6363),
    secondTextColor: const Color(0xFFFFFFFF),
  ),
  MyTheme(
    primary: const Color(0xff4B6176),
    secondary: const Color(0xffC2F1DC),
    textColor: const Color(0xFFFFFFFF),
    secondTextColor: const Color(0xFF000000),
  ),
  MyTheme(
    primary: const Color(0xFFB85659),
    secondary: const Color(0xffffffff),
    textColor: const Color(0xFFFFFFFF),
    secondTextColor: const Color(0xFF000000),
  ),
];
