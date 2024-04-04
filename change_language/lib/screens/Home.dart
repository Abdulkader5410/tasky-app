import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/locale_cubit.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<LocaleCubit, LocaleState>(builder: (context, state) {
        if (state is ChangeLocaleState) {
          return Center(
              child: DropdownButton(
                  value: state.locale!.languageCode,
                  items: ['ar', 'en'].map((String items) {
                    return DropdownMenuItem<String>(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newVal) {
                    BlocProvider.of<LocaleCubit>(context).changeLang(newVal!);
                  }));
        } else {
          return const SizedBox();
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Text("+"),
      ),
      //
      // Text(AppLocalizations.of(context)!.translate("hello_msg"))),
    );
  }
}