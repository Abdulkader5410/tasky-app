import 'package:flutter/material.dart';

const primaryColor = Colors.deepPurple;
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
    //theme of field
    inputDecorationTheme: const InputDecorationTheme(
      
       
        enabledBorder: OutlineInputBorder(

            borderSide: BorderSide(color: Colors.grey,),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black,),
            borderRadius: BorderRadius.all(Radius.circular(12)))),
    );

const styleTitles = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
const styleSubtites = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
const stylebody = TextStyle(fontSize: 12, fontWeight: FontWeight.w200);
