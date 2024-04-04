import 'package:change_themes/Screens/HomeScreen.dart';
import 'package:change_themes/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyTheme());
}

class MyTheme extends StatefulWidget {
  const MyTheme({super.key});

  @override
  State<MyTheme> createState() => _MyThemeState();
}

class _MyThemeState extends State<MyTheme> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc()..add(GetCurrentThemeEvent()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is LoadedThemeState) {
            return  MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state.themeData,
              home: const HomeSreen(),
            );
          } 
            return const SizedBox();
          
        },
      ),
    );
  }
}