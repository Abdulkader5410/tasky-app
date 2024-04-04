import 'package:shared_preferences/shared_preferences.dart';

class CashThemeHelper {
  Future<void> chashedTheme(int themeIndex) async {
    final SharedPreferences shared_preferences =
        await SharedPreferences.getInstance();
    shared_preferences.setInt("THEME_INDEX", themeIndex);
  }

  Future<int> getChashedTheme( ) async {
    final SharedPreferences shared_preferences =
        await SharedPreferences.getInstance();
    final chashedTheme = await shared_preferences.getInt("THEME_INDEX");
    if (chashedTheme != null) {
      return chashedTheme;
    } else {
      return 0;
    }
  }
}
