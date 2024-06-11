import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/core/api/dio_consumer.dart';
import 'package:untitled2/core/app_theme/app_theme.dart';
import 'package:untitled2/cubit/logout_cubit/logout_cubit.dart';
import 'package:untitled2/cubit/signin_cubit/signin_cubit.dart';
import 'package:untitled2/cubit/signup_cubit/signup_cubit.dart';
import 'package:untitled2/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:untitled2/features/splash_-screen.dart';
import 'package:untitled2/features/task/presentation/bloc/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:untitled2/features/task/presentation/bloc/task/task_bloc.dart';
import 'package:untitled2/features/task/presentation/ui/task_screen.dart';
import 'package:untitled2/get_it.dart' as getIt;

Future<dynamic> getLocalUser() async {
  SharedPreferences sp = await SharedPreferences.getInstance();

  dynamic user = sp.getString("access_token");
  if (user != null) {
    return user;
  }
  else{
    return null;
  }
}

dynamic xx;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // CacheHelper().init();
  await getIt.init();
  runApp(const MyApp());

  xx = await getLocalUser();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    getLocalUser();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ProfileBloc(profileUserUC: getIt.sl())),
        BlocProvider(
            create: (context) => AddDeleteUpdateBloc(
                addTask: getIt.sl(),
                deleteTask: getIt.sl(),
                updateTask: getIt.sl())),
        BlocProvider(
            create: (context) =>
                TaskBloc(getOneTask: getIt.sl(), getAllTasks: getIt.sl())),
        BlocProvider(create: (context) => SigninCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (context) => SignupCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (context) => LogoutCubit(DioConsumer(dio: Dio()))),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tasky',
        theme: appTheme,
        home: xx != null ? TaskPage() : const SplashPage(),
      ),
    );
  }
}
