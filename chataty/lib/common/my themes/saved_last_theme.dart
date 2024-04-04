// ignore_for_file: slash_for_doc_comments

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

 class  SavedLastTheme {

/**
 light theme = 1
 dark theme = 0
 null = -1
*/
  static Future<void> savedTheme(int isLigh) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setInt("IS_LIGHT", isLigh);
  }

  static Future<int> getTheme() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
     final cashedTheme = sharedPreferences.getInt("IS_LIGHT");

    if(cashedTheme != null){
      return cashedTheme;
    }
    else{
      return -1;
    }
  }
}

final lastThemeProvider = Provider((ref) => SavedLastTheme.getTheme());