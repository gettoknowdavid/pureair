import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/bottom_nav/bloc/bottom_nav_bloc.dart';
import 'core/client/aqi_client.dart';
import 'core/database/app_database.dart';
import 'core/network/network_info.dart';
import 'features/aqi/data/data_sources/aqi_local_data_source.dart';
import 'features/aqi/data/data_sources/aqi_remote_data_source.dart';
import 'features/aqi/data/repositories/aqi_repository_imp.dart';
import 'features/aqi/domain/repositories/aqi_repository.dart';
import 'features/aqi/domain/usecases/get_aqi_by_condition_usecase.dart';
import 'features/aqi/domain/usecases/update_aqi_by_condition_usecase.dart';
import 'features/aqi/presentation/blocs/aqi_by_condition_bloc.dart';
import 'features/favourites/data/datasources/favourites_local_datasource.dart';
import 'features/favourites/data/repositories/favourites_repository_imp.dart';
import 'features/favourites/domain/repositories/favourites_repository.dart';
import 'features/favourites/domain/usecases/add_favourite_usecase.dart';
import 'features/favourites/domain/usecases/get_favourites_usecase.dart';
import 'features/favourites/domain/usecases/remove_favourite_usecase.dart';
import 'features/favourites/presentation/bloc/favourites_bloc.dart';
import 'features/search/data/datasources/search_remote_data_source.dart';
import 'features/search/data/repositories/search_repository_imp.dart';
import 'features/search/domain/repositories/search_repository.dart';
import 'features/search/domain/usecases/get_search_details_usecase.dart';
import 'features/search/domain/usecases/search_city_usecase.dart';
import 'features/search/presentation/blocs/search_aqi/search_aqi_bloc.dart';
import 'features/search/presentation/blocs/search_details/search_details_bloc.dart';

final sl = GetIt.instance;

Future<void> initialize() async {
  // Initializing PureAir Database
  final appDatabase = await AppDatabase.initialize();

  // Blocs
  //
  // Bottom Navigation Bar Bloc
  sl.registerFactory<BottomNavBloc>(() => BottomNavBloc());

  // Air Quality by Condition Bloc
  sl.registerFactory<AqiByConditionBloc>(
    () => AqiByConditionBloc(
      getAqiUseCase: sl(),
      updateAqiUseCase: sl(),
    ),
  );

  // Search Air Quality Bloc
  sl.registerFactory<SearchAqiBloc>(
    () => SearchAqiBloc(searchCityUseCase: sl()),
  );

  // Search Details Air Quality Bloc
  sl.registerFactory<SearchDetailsBloc>(
    () => SearchDetailsBloc(getDetailsUseCase: sl()),
  );

  // Favourites Air Quality Bloc
  sl.registerFactory<FavouritesBloc>(
    () => FavouritesBloc(
      getFavourites: sl(),
      addFavourite: sl(),
      removeFavourite: sl(),
    ),
  );

  // Repositories
  //
  // Air Quality Repositories
  sl.registerLazySingleton<AqiRepository>(
    () => AqiRepositoryImplementation(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Search Air Quality Repositories
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImplementation(
      remoteDataSource: sl(),
      aqiLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Favourites Repositories
  sl.registerLazySingleton<FavouritesRepository>(
    () => FavouritesRepositoryImplementation(
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Air Quality Remote Repository
  sl.registerLazySingleton<AqiRemoteDataSource>(
    () => AqiRemoteDataSourceImplementation(client: sl()),
  );

  // Search Air Quality Remote Repository
  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImplementation(client: sl()),
  );

  // Air Quality Local Repository
  sl.registerLazySingleton<AqiLocalDataSource>(
    () => AqiLocalDataSourceImplementation(database: sl()),
  );

  // Favourites Local Repository
  sl.registerLazySingleton<FavouritesLocalDataSource>(
    () => FavouritesLocalDataSourceImplementation(database: sl()),
  );

  sl.registerLazySingleton<AppDatabase>(() => appDatabase);

  // Air Quality Remote Client
  sl.registerLazySingleton<AqiClient>(() => AqiClient(sl()));

  // Usecases
  //
  // Get Air Quality by Condition Usecase
  sl.registerLazySingleton<GetAqiByConditionUseCase>(
    () => GetAqiByConditionUseCase(repository: sl()),
  );

  // Update Air Quality by Condition Usecase
  sl.registerLazySingleton<UpdateAqiByConditionUseCase>(
    () => UpdateAqiByConditionUseCase(repository: sl()),
  );

  // Get Search Details Usecase
  sl.registerLazySingleton<GetSearchDetailsUseCase>(
    () => GetSearchDetailsUseCase(repository: sl()),
  );

  // Search City Air Quality Usecase
  sl.registerLazySingleton<SearchCityUseCase>(
    () => SearchCityUseCase(repository: sl()),
  );

  // Add Favourites Usecase
  sl.registerLazySingleton<AddFavouriteUseCase>(
    () => AddFavouriteUseCase(repository: sl()),
  );

  // Remove Favourites Usecase
  sl.registerLazySingleton<RemoveFavouriteUseCase>(
    () => RemoveFavouriteUseCase(repository: sl()),
  );

  // Get Favourites Usecase
  sl.registerLazySingleton<GetFavouritesUseCase>(
    () => GetFavouritesUseCase(repository: sl()),
  );
  // External
  //
  // Dio
  sl.registerLazySingleton<Dio>(() => Dio());

  // Network Info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImplementation(sl()),
  );

  // Data Connection Checker
  sl.registerLazySingleton<DataConnectionChecker>(
    () => DataConnectionChecker(),
  );
}
