import 'package:flutter/material.dart';

// const colorSeed = Color(0xff424CB8);
// const scaffoldBackgroundColor = Color.fromARGB(255, 18, 27, 133);

const primaryColor = Color(0xff00458a);
const textColor = Color.fromARGB(0, 255, 255, 255);
const scaffoldBackgroundColor = Color.fromARGB(255, 243, 249, 255);
const String helveticaFont = 'Helvetica';

class AppTheme {
  ThemeData getTheme() => ThemeData(
      fontFamily: helveticaFont,

      ///* General
      colorSchemeSeed: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      // primaryColor: primaryColor,

      /// Text themes
      textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 30, color: primaryColor),
          titleMedium: TextStyle(
              fontWeight: FontWeight.w100,
              fontSize: 15,
              color: primaryColor)));
}
