import 'package:shared_preferences/shared_preferences.dart';

class CashedLang {
  Future<void> chashedLang(String langCode) async {
    final SharedPreferences shared_preferences =
        await SharedPreferences.getInstance();
    shared_preferences.setString("LOCALE", langCode);
  }

  Future<String> getChashedLang( ) async {
    final SharedPreferences shared_preferences =
        await SharedPreferences.getInstance();
    final chashedLang = await shared_preferences.getString("LOCALE");
    if (chashedLang != null) {
      return chashedLang;
    } else {
      return "en";
    }
  }
}
