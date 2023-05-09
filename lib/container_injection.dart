import 'package:astronomy_picture/core/util/network_info.dart';
import 'package:astronomy_picture/core/util/notifications.dart';
import 'package:astronomy_picture/features/apod/data/datasources/abstract/apod_local_data_source.dart';
import 'package:astronomy_picture/features/apod/data/datasources/abstract/apod_remote_data_source.dart';
import 'package:astronomy_picture/features/apod/data/datasources/apod_local_data_source_impl.dart';
import 'package:astronomy_picture/features/apod/data/datasources/apod_remote_data_source_impl.dart';
import 'package:astronomy_picture/features/apod/data/repositories/apod_local_repository_impl.dart';
import 'package:astronomy_picture/features/apod/data/repositories/apod_repository_impl.dart';
import 'package:astronomy_picture/features/apod/domain/repositories/apod_local_repository.dart';
import 'package:astronomy_picture/features/apod/domain/repositories/apod_repository.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/apod_is_save.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/fetch_apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/fetch_search_history.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_all_apod_save.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_apod_by_date_range.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_apod_from_date.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_random_apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/get_today_apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/remove_save_apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/save_apod.dart';
import 'package:astronomy_picture/features/apod/domain/usecases/update_search_history.dart';
import 'package:astronomy_picture/features/apod/presentation/bloc/apod_bloc.dart';
import 'package:astronomy_picture/route_generato.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
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
  apodFeature();
}

void apodFeature() {
  // datasources
  getIt.registerLazySingleton<ApodRemoteDataSource>(
      () => ApodRemoteDataSourceImpl(client: getIt()));
  getIt.registerLazySingleton<ApodLocalDataSource>(
      () => ApodLocalDataSourceImpl(sharedPreferences: getIt()));

  // repository
  getIt.registerLazySingleton<ApodRepository>(() =>
      ApodRepositoryImpl(remoteDataSource: getIt(), networkInfo: getIt()));
  getIt.registerLazySingleton<ApodLocalRepository>(
      () => ApodLocalRepositoryImpl(localDataSource: getIt()));

  // usecases
  getIt.registerLazySingleton(() => GetTodayApod(repository: getIt()));
  getIt.registerLazySingleton(() => GetRandomApod(repository: getIt()));
  getIt.registerLazySingleton(() => GetApodFromDate(repository: getIt()));
  getIt.registerLazySingleton(() => FetchApod(repository: getIt()));
  getIt.registerLazySingleton(() => GetApodByDateRange(repository: getIt()));
  getIt.registerLazySingleton(() => ApodIsSave(repository: getIt()));
  getIt.registerLazySingleton(() => GetAllApodSave(repository: getIt()));
  getIt.registerLazySingleton(() => RemoveSaveApod(repository: getIt()));
  getIt.registerLazySingleton(() => SaveApod(repository: getIt()));
  getIt.registerLazySingleton(() => FetchSearchHistory(repository: getIt()));
  getIt.registerLazySingleton(() => UpdateSearchHistory(repository: getIt()));

  // bloc
  getIt.registerFactory(() => ApodBloc(
        getTodayApod: getIt(),
        getRandomApod: getIt(),
        getApodFromDate: getIt(),
        fetchApod: getIt(),
        getApodByDateRange: getIt(),
        apodIsSave: getIt(),
        getAllApodSave: getIt(),
        removeSaveApod: getIt(),
        saveApod: getIt(),
        fetchSearchHistory: getIt(),
        updateSearchHistory: getIt(),
      ));
}
