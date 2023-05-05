import 'package:flutter/material.dart';

class PersonalTheme {
  //Nasa Colors
  static Color blue = const Color(0xFF105bd8);
  static Color blueDarker = const Color(0xFF0b3d91);
  static Color blueDarkest = const Color(0xFF0b3d91);
  static Color black = const Color(0xFF212121);
  static Color palePink = const Color(0xfff9e0de);
  static Color vermilion = const Color(0xFFdd361c);
  static Color white = const Color(0xFFf1f1f1);

  // Space Colors
  static Color spaceBlue = const Color(0xFF26203A);

  ThemeData get theme => ThemeData(
      primaryColor: blue,
      primaryColorDark: blueDarker,
      scaffoldBackgroundColor: white,
      appBarTheme:
          AppBarTheme(color: blue, iconTheme: IconThemeData(color: palePink)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: blue,
          unselectedItemColor: palePink.withOpacity(0.5),
          selectedItemColor: palePink),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: vermilion)),
      snackBarTheme: SnackBarThemeData(
          backgroundColor: spaceBlue,
          contentTextStyle: TextStyle(color: white)));
}
