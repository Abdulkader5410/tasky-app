import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/api/dio_consumer.dart';
import 'package:ecommerce_app/cubit/user_cubit.dart';

import 'package:ecommerce_app/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

late Size mediaQuery;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(DioConsumer(dio: Dio())),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SigninScreen()
      ),
    );
  }
}
