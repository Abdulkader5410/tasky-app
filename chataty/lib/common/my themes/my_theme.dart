import 'package:chataty/common/colors/coloors.dart';
import 'package:flutter/material.dart';

class MyCustomTheme {
  ThemeData lightTheme = ThemeData.light().copyWith(
    dialogBackgroundColor: Coloors.light,
    splashColor: Coloors.teal,
    dialogTheme: DialogTheme(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Coloors.teal))),
    bottomSheetTheme: const BottomSheetThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: Coloors.light),
    appBarTheme: const AppBarTheme(backgroundColor: Coloors.teal, elevation: 1),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Coloors.light,
    primaryColor: Colors.teal,
  );

  ThemeData darkTheme = ThemeData.light().copyWith(
      splashColor: Coloors.teal,
      dialogBackgroundColor: Coloors.greyDark,
      dialogTheme: DialogTheme(
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Coloors.teal))),
      bottomSheetTheme: const BottomSheetThemeData(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          backgroundColor: Coloors.greyDark),
      appBarTheme:
          const AppBarTheme(backgroundColor: Coloors.greyDark, elevation: 1),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Coloors.dark,
      primaryColor: Coloors.teal);
}
