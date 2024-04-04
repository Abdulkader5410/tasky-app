import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/post/data/data_source/local_data_source.dart';
import 'package:posts_app/features/post/data/data_source/remot_data_source.dart';
import 'package:posts_app/features/post/data/post_data_repo/post_data_repo.dart';
import 'package:posts_app/features/post/domain/usecase/add_post.dart';
import 'package:posts_app/features/post/domain/usecase/delete_post.dart';
import 'package:posts_app/features/post/domain/usecase/get_all_post.dart';
import 'package:posts_app/features/post/domain/usecase/update_post.dart';
import 'package:posts_app/features/post/presentation/bloc/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:posts_app/features/post/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initS() async {
  //// features - posts

  // bloc

  sl.registerFactory(() => PostsBloc(getAllPsots: sl()));
  sl.registerFactory(() =>
      AddDeleteUpdateBloc(addPost: sl(), deletePost: sl(), updatePost: sl()));

  //usecase

  sl.registerLazySingleton(() => AddPostUC(sl()));
  sl.registerLazySingleton(() => DeletePostUC(sl()));
  sl.registerLazySingleton(() => UpdatePostUC(sl()));
  sl.registerLazySingleton(() => GetAllPsotsUC(sl()));

  //repo

  sl.registerLazySingleton<PostDataRepo>(() => PostDataRepo(
      networkinfo: sl(), remoteDataSource: sl(), localDataSource: sl()));

  //datasource

  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(sp: sl()));

  //// core
  
  sl.registerLazySingleton(() => NetworkinfoImpl(netCheck: sl()));

  //// external
  
  SharedPreferences sp = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sp);

  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton(() => http.Client());


}
