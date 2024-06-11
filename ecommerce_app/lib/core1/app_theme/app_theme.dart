import 'package:flutter/material.dart';

const primaryColor = Color(0xff082659);
const secondaryColor = Color(0xff5178c2);

final appTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
    ),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(primary: primaryColor),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: secondaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor, foregroundColor: secondaryColor),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: const TextStyle(
        color: primaryColor,
      ),
      iconColor: primaryColor,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primaryColor)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: secondaryColor)),
    ));

const styleTitles = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
const styleSubtites = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
const stylebody = TextStyle(fontSize: 12, fontWeight: FontWeight.w200);
