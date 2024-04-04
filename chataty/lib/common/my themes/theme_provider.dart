import 'package:chataty/common/my themes/saved_last_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyThemeState {
  bool? isLightTheme;
  MyThemeState({required this.isLightTheme});
}

class MyThemeNotifier extends StateNotifier<MyThemeState> {
  bool? isLightTheme;

  MyThemeNotifier() : super(MyThemeState(isLightTheme: false));

  void toggleLight() {
    state = MyThemeState(isLightTheme: true);
    SavedLastTheme.savedTheme(1);
  }

  void toggleDark() {
    state = MyThemeState(isLightTheme: false);
    SavedLastTheme.savedTheme(0);
  }
}

final myThemeProvider = StateNotifierProvider<MyThemeNotifier, MyThemeState>(
    (ref) => MyThemeNotifier());