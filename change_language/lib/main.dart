import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:local/Local/AppLocalizations.dart';
import 'package:local/cubit/locale_cubit.dart';
import 'package:local/screens/Home.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LocaleCubit()..getSavedLang(),
          ),
        ],
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            if (state is ChangeLocaleState) {
              return MaterialApp(
                locale: state.locale,
                supportedLocales: const [
                  Locale("en"),
                  Locale("ar"),
                ],
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var l in supportedLocales) {
                    if (locale != null &&
                        l.languageCode == locale.languageCode) {
                      return locale;
                    }
                  }
                  return supportedLocales.first;
                },
                debugShowCheckedModeBanner: false,
                home: const Home(),
              );
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}
