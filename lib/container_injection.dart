import 'package:astronomy_picture/data/datasources/bookmark_apod/bookmark_apod_data_source.dart';
import 'package:astronomy_picture/data/datasources/bookmark_apod/bookmark_apod_impl.dart';
import 'package:astronomy_picture/data/datasources/fetch_apod/fetch_apod_data_source.dart';
import 'package:astronomy_picture/data/datasources/fetch_apod/fetch_apod_data_source_impl.dart';
import 'package:astronomy_picture/data/datasources/network/network_info.dart';
import 'package:astronomy_picture/data/datasources/notifications/notifications.dart';
import 'package:astronomy_picture/data/datasources/search/interfaces/search_local_data_source.dart';
import 'package:astronomy_picture/data/datasources/search/interfaces/search_remote_data_source.dart';
import 'package:astronomy_picture/data/datasources/search/search_local_data_source_impl.dart';
import 'package:astronomy_picture/data/datasources/search/search_remote_data_source_impl.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source_impl.dart';
import 'package:astronomy_picture/data/repositories/bookmark_apod/bookmark_apod_repository_impl.dart';
import 'package:astronomy_picture/data/repositories/fetch_apod/fetch_apod_repository_impl.dart';
import 'package:astronomy_picture/data/repositories/search/search_repository_impl.dart';
import 'package:astronomy_picture/data/repositories/today_apod/today_apod_repository_impl.dart';
import 'package:astronomy_picture/domain/repositories/bookmark_apod/bookmark_apod_repository.dart';
import 'package:astronomy_picture/domain/repositories/fetch_apod/fetch_apod_repository.dart';
import 'package:astronomy_picture/domain/repositories/search/search_repository.dart';
import 'package:astronomy_picture/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:astronomy_picture/domain/usecases/bookmark_apod/apod_is_save.dart';
import 'package:astronomy_picture/domain/usecases/bookmark_apod/get_all_apod_save.dart';
import 'package:astronomy_picture/domain/usecases/bookmark_apod/remove_save_apod.dart';
import 'package:astronomy_picture/domain/usecases/bookmark_apod/save_apod.dart';
import 'package:astronomy_picture/domain/usecases/fetch_apod/fetch_apod.dart';
import 'package:astronomy_picture/domain/usecases/search/fetch_search_history.dart';
import 'package:astronomy_picture/domain/usecases/search/get_apod_by_date_range.dart';
import 'package:astronomy_picture/domain/usecases/search/update_search_history.dart';
import 'package:astronomy_picture/domain/usecases/today_apod/get_today_apod.dart';
import 'package:astronomy_picture/presentation/bloc/bookmark_apod/bookmark_apod_bloc.dart';
import 'package:astronomy_picture/presentation/bloc/fetch_apod/fetch_apod_bloc.dart';
import 'package:astronomy_picture/presentation/bloc/search/search_bloc.dart';
import 'package:astronomy_picture/presentation/bloc/today_apod/today_apod_bloc.dart';
import 'package:astronomy_picture/route_generato.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future<void> setupContainer() async {
  // External
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  getIt.registerLazySingleton<FlutterLocalNotificationsPlugin>(
      () => FlutterLocalNotificationsPlugin());
  final sharedPreference = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreference);

  // Internal
  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnection: getIt()));
  getIt.registerLazySingleton<Notifications>(
    () => NotificationsImpl(notificationsPlugin: getIt()),
  );
  getIt.registerLazySingleton<RouteGenerato>(() => RouteGenerato());

  // Features
  bookmarkApod();
  fetchApod();
  search();
  todayApod();
}

void bookmarkApod() {
  getIt.registerLazySingleton<BookmarkApodDataSource>(
      () => BookmarkApodDataSourceImpl(sharedPreferences: getIt()));

  getIt.registerLazySingleton<BookmarkApodRepository>(
      () => BookmarkApodRepositoryImpl(bookmarkApodDataSource: getIt()));

  getIt.registerLazySingleton(() => ApodIsSave(repository: getIt()));
  getIt.registerLazySingleton(() => GetAllApodSave(repository: getIt()));
  getIt.registerLazySingleton(() => RemoveSaveApod(repository: getIt()));
  getIt.registerLazySingleton(() => SaveApod(repository: getIt()));

  getIt.registerFactory(() => BookmarkApodBloc(
      apodIsSave: getIt(),
      getAllApodSave: getIt(),
      removeSaveApod: getIt(),
      saveApod: getIt()));
}

void fetchApod() {
  getIt.registerLazySingleton<FetchApodDataSource>(
      () => FetchApodDataSourceImpl(client: getIt()));

  getIt.registerLazySingleton<FetchApodRepository>(() =>
      FetchApodRepositoryImpl(
          fetchApodDataSource: getIt(), networkInfo: getIt()));

  getIt.registerLazySingleton(() => FetchApod(repository: getIt()));

  getIt.registerFactory(() => FetchApodBloc(fetchApod: getIt()));
}

void search() {
  getIt.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(client: getIt()));
  getIt.registerLazySingleton<SearchLocalDataSource>(
      () => SearchLocalDataSourceImpl(sharedPreferences: getIt()));

  getIt.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl(
      localDataSource: getIt(),
      remoteDataSource: getIt(),
      networkInfo: getIt()));

  getIt.registerLazySingleton(() => FetchSearchHistory(repository: getIt()));
  getIt.registerLazySingleton(() => GetApodByDateRange(repository: getIt()));
  getIt.registerLazySingleton(() => UpdateSearchHistory(repository: getIt()));

  getIt.registerFactory(() => SearchBloc(
      fetchSearchHistory: getIt(),
      updateSearchHistory: getIt(),
      getApodByDateRange: getIt()));
}

void todayApod() {
  getIt.registerLazySingleton<TodayApodDataSource>(
      () => TodayApodDataSourceImpl(client: getIt()));

  getIt.registerLazySingleton<TodayApodRepository>(() =>
      TodayApodRepositoryImpl(
          todayApodDataSource: getIt(), networkInfo: getIt()));

  getIt.registerLazySingleton(() => GetTodayApod(repository: getIt()));

  getIt.registerFactory(() => TodayApodBloc(todayApod: getIt()));
}
