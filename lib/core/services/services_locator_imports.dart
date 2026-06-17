part of 'services_locator.dart';

final sl = GetIt.instance;
Future<void> initDependencies() async {
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
  sl.registerLazySingleton<AppInterceptors>(() => AppInterceptors());
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerFactory<ApiConsumer>(() => DioConsumer(client: sl()));
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()));
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit(sl()));
  sl.registerLazySingleton<FavoritesCubit>(() => FavoritesCubit());
  sl.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(sl()));
  sl.registerLazySingleton<HomeCubit>(() => HomeCubit(sl()));
  sl.registerLazySingleton<AdminRepo>(() => AdminRepoImp(apiConsumer: sl()));
  sl.registerLazySingleton<AdminCubit>(() => AdminCubit(sl()));
  sl.registerLazySingleton<AgentRepo>(() => AgentImplRepo(sl()));
  sl.registerLazySingleton<AgentCubit>(() => AgentCubit(sl()));
}
