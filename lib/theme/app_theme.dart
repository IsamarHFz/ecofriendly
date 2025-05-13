import 'package:flutter/material.dart';

class AppTheme {
  static const textColor = Color.fromARGB(255, 0, 0, 0);
  static const iconColor = Color.fromARGB(255, 255, 255, 255);
  static const buttonColor = Color.fromARGB(210, 33, 126, 10);
  static const foundColor = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Colors.white, Color.fromARGB(255, 61, 138, 64)],
    ),
  );
}
