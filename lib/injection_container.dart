import 'package:flickr_test_app/core/network/network_info.dart';
import 'package:flickr_test_app/features/search_page/data/datasources/search_page_remote_data_source.dart';
import 'package:flickr_test_app/features/search_page/data/repositories/search_page_repository_impl.dart';
import 'package:flickr_test_app/features/search_page/domain/usecases/search_page_usecase_get_photos.dart';
import 'package:flickr_test_app/features/search_page/presentation/bloc/search_page_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/search_page/domain/repositories/search_page_repository.dart';

final GetIt sl = GetIt.instance; // 'sl' means service locator

Future<void> init() async {
  //Bloc

  sl.registerFactory(() => SearchPageBloc(fetchPhotos: sl()));

  //Use cases
  sl.registerLazySingleton(() => FetchPhotos(searchPageRepository: sl()));

  //Repositories
  sl.registerLazySingleton <SearchPageRepository>(
          () => SearchPageRepositoryImpl(
              remoteDataSource: sl(),
              networkInfo: sl(),
          )
  );

  //Remote data sources
  sl.registerLazySingleton <SearchPageRemoteDataSource>(
          () => SearchPageRemoteDataSourceImpl(
              client: sl(),
          ),
  );

  //Core
  sl.registerLazySingleton <NetworkInfo>(
          () => NetworkInfoImpl(
              connectionChecker: sl()
          )
  );

  //External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}