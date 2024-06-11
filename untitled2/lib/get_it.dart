import 'package:dio/dio.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled2/core/api/dio_consumer.dart';
import 'package:untitled2/core/network/network_info.dart';
import 'package:untitled2/features/profile/data/data_repo/profile_data_repo.dart';
import 'package:untitled2/features/profile/data/data_source/profile_local_data_source.dart';
import 'package:untitled2/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:untitled2/features/profile/domain/dom_repo/profile_dom_repo.dart';
import 'package:untitled2/features/profile/domain/usecase/profile_usecase.dart';
import 'package:untitled2/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:untitled2/features/signin/data/data_repo/signin_data_repo.dart';
import 'package:untitled2/features/signin/data/data_source/signin_local_data_source.dart';
import 'package:untitled2/features/signin/data/data_source/signin_remote_data_source.dart';
import 'package:untitled2/features/signin/domain/dom_repo/signin_dom_repo.dart';
import 'package:untitled2/features/signin/domain/usecase/signin_usecase.dart';
import 'package:untitled2/features/signin/presentation/bloc/signin/signin_bloc.dart';
import 'package:untitled2/features/signup/data/data_repo/signup_data_repo.dart';
import 'package:untitled2/features/signup/data/data_source/signup_local_data_source.dart';
import 'package:untitled2/features/signup/data/data_source/signup_remote_data_source.dart';
import 'package:untitled2/features/signup/domain/dom_repo/signup_dom_repo.dart';
import 'package:untitled2/features/signup/domain/usecase/signup_usecase.dart';
import 'package:untitled2/features/signup/presentation/bloc/signup/signup_bloc.dart';
import 'package:untitled2/features/task/data/data_source/task_local_data_source.dart';
import 'package:untitled2/features/task/data/data_source/task_remot_data_source.dart';
import 'package:untitled2/features/task/data/task_data_repo/task_data_repo.dart';
import 'package:untitled2/features/task/domain/task_domain_repo/task_dom_repo.dart';
import 'package:untitled2/features/task/domain/usecase/add_task.dart';
import 'package:untitled2/features/task/domain/usecase/delete_task.dart';
import 'package:untitled2/features/task/domain/usecase/get_all_tasks.dart';
import 'package:untitled2/features/task/domain/usecase/get_one_task_usecase.dart';
import 'package:untitled2/features/task/domain/usecase/update_task.dart';
import 'package:untitled2/features/task/presentation/bloc/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:untitled2/features/task/presentation/bloc/task/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // bloc

  sl.registerFactory(() => SignInBloc(signInUserUC: sl()));
  sl.registerFactory(() => SignUpBloc(signUpUserUC: sl()));
  sl.registerFactory(() => ProfileBloc(profileUserUC: sl()));
  sl.registerFactory(() => TaskBloc(getAllTasks: sl(), getOneTask: sl()));

  sl.registerFactory(() =>
      AddDeleteUpdateBloc(addTask: sl(), deleteTask: sl(), updateTask: sl()));

//usecase

  sl.registerFactory(() => SignInUserUC(signInDomRepo: sl()));
  sl.registerFactory(() => SignUpUserUC(signupDomRepo: sl()));
  sl.registerFactory(() => ProfileUserUC(profileDomRepo: sl()));

  sl.registerFactory(() => AddTaskUC(taskDomRepo: sl()));
  sl.registerFactory(() => UpdateTasktUC(taskDomRepo: sl()));
  sl.registerFactory(() => DeleteTaskUC(taskDomRepo: sl()));

  sl.registerFactory(() => GetAllTasksUC(taaskDomRepo: sl()));

  sl.registerFactory(() => GetOneTasksUC(taaskDomRepo: sl()));


//repo

  sl.registerFactory<SignUpDomRepo>(() => SignUpDataRepo(
        networkinfo: sl(), remoteDataSource: sl(),
        //  localDataSource: sl()
      ));

  sl.registerFactory<SignInDomRepo>(() => SignInDataRepo(
        networkinfo: sl(), remoteDataSource: sl(),
        // localDataSource: sl()
      ));

  sl.registerFactory<ProfileDomRepo>(() => ProfileDataRepo(
      networkinfo: sl(), remoteDataSource: sl(), localDataSource: sl()));

  sl.registerFactory<TaskDomRepo>(
      () => TaskDataRepo(networkinfo: sl(), taskRemoteDataSource: sl()));

  //datasource

  sl.registerFactory<DioConsumer>(() => DioConsumer(dio: sl()));

  // sl.registerFactory<SignUpLocalDataSource>(
  //     () => SignUpLocalDataSourceImpl(sp: sl()));

  sl.registerFactory<SignUpRemoteDataSource>(
      () => SignUpRemoteDataSourceImpl(dio: sl()));

  sl.registerFactory<TaskRemoteDataSource>(
      () => TaskRemoteDataSourceImpl(dio: sl()));

  // sl.registerFactory<TaskLocalDataSource>(
  //     () => TaskLocalDataSourceImpl(sp: sl()));

  // sl.registerFactory<SignInLocalDataSource>(
  //     () => SignInLocalDataSourceImpl(sp: sl()));

  sl.registerFactory<SignInRemoteDataSource>(
      () => SignInRemoteDataSourceImpl(dio: sl()));

  sl.registerFactory<ProfileLocalDataSource>(
      () => ProfileLocalDataSourceImpl(sp: sl()));

  sl.registerFactory<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(dio: sl()));

  //// core

  sl.registerFactory<Networkinfo>(() => NetworkinfoImpl(netCheck: sl()));

  //// external

  SharedPreferences sp = await SharedPreferences.getInstance();
  sl.registerFactory(() => sp);

  sl.registerFactory(() => InternetConnectionChecker());

  sl.registerFactory(() => Dio());
}
