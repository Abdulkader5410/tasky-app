import 'package:flutter/material.dart';

enum MyThemes {
  blueLight("Blue Light"),
  blueDark("Blue Dark"),
  redDark("Red Dark");

  const MyThemes(this.name);
  final String? name;
}

final myThemeData = {
  MyThemes.blueLight: ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
      brightness: Brightness.light,
      primaryColor: Colors.blue),
  MyThemes.blueDark: ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: Colors.blue[700]),
      brightness: Brightness.dark,
      primaryColor: Colors.blue[700]),
  MyThemes.redDark: ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: Colors.red[700]),
      brightness: Brightness.dark,
      primaryColor: Colors.red)
};
