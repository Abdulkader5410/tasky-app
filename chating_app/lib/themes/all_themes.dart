import 'package:flutter/material.dart';

Color darkRed = const Color(0xff8a031e);
Color darkpurple = const Color(0xff7f0f40);
Color orang = const Color(0xfffbbb24);
Color light = const Color(0xffeeeddd);
Color dark = const Color(0xff221111);

enum AllThemes {
  blueLight("Blue Light"),
  blueDark("Blue Dark");

  const AllThemes(this.name);
  final String? name;
}

final myThemeData = {
  AllThemes.blueLight: ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: darkRed),
      scaffoldBackgroundColor: light,
      primaryColor: darkRed,
      buttonTheme: ButtonThemeData(buttonColor: darkRed)),
  AllThemes.blueDark: ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: darkRed),
      scaffoldBackgroundColor: dark,
      primaryColor: darkRed,
      buttonTheme: ButtonThemeData(buttonColor: darkRed))
};
