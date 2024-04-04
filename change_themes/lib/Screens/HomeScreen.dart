import 'package:change_themes/Themes/MyThemes.dart';
import 'package:change_themes/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSreen extends StatefulWidget {
  const HomeSreen({super.key});

  @override
  State<HomeSreen> createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ListView.builder(
            itemCount: MyThemes.values.length,
            itemBuilder: (context, index) {
              final itemMyTheme = MyThemes.values[index];
              return Card(
                color: myThemeData[itemMyTheme]!.primaryColor,
                child: ListTile(
                  title: Text(itemMyTheme.name!),
                  onTap: () {
                    context.read<ThemeBloc>()
                        .add(ChangeThemeEvent(myThemes: itemMyTheme));
                  },
                ),
              );
            },
          ),
        ));
  }
}
