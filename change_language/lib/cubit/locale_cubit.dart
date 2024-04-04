import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:local/utilities/CashedLang.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleInitial());

  Future<void> getSavedLang() async {
    String savedLang = await CashedLang().getChashedLang();
    emit(ChangeLocaleState(locale: Locale(savedLang)));
  }

  Future<void> changeLang(String langCode) async {
    await CashedLang().chashedLang(langCode);
    emit(ChangeLocaleState(locale: Locale(langCode)));
  }
}
