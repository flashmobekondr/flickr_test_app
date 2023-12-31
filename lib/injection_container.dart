import 'package:flickr_test_app/core/network/network_info.dart';
import 'package:flickr_test_app/features/detail_page/data/datasources/detail_page_data_transform_impl.dart';
import 'package:flickr_test_app/features/detail_page/domain/usecases/detail_page_usecase_transform_data.dart';
import 'package:flickr_test_app/features/detail_page/presentation/bloc/detail_page_bloc.dart';
import 'package:flickr_test_app/features/favorite_page/data/repositories/favorite_page_repository_impl.dart';
import 'package:flickr_test_app/features/favorite_page/domain/repositories/favorite_page_repository.dart';
import 'package:flickr_test_app/features/favorite_page/domain/usecases/favorite_page_usecase_add_delete_photos.dart';
import 'package:flickr_test_app/features/favorite_page/domain/usecases/favorite_page_usecase_get_favorite_photos.dart';
import 'package:flickr_test_app/features/favorite_page/presentation/bloc/favorite_page_bloc.dart';
import 'package:flickr_test_app/features/search_page/data/datasources/search_page_remote_data_source.dart';
import 'package:flickr_test_app/features/search_page/data/repositories/search_page_repository_impl.dart';
import 'package:flickr_test_app/features/search_page/domain/usecases/search_page_usecase_fetch_photos.dart';
import 'package:flickr_test_app/features/search_page/presentation/bloc/search_page_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/favorite_page/data/datasources/favorite_page_local_data_source.dart';
import 'features/search_page/domain/repositories/search_page_repository.dart';

final GetIt sl = GetIt.instance; // 'sl' means service locator

Future<void> init() async {
  //Bloc
  sl.registerFactory(() => SearchPageBloc(fetchPhotos: sl()));
  sl.registerFactory(() => DetailPageBloc(transformData: sl()));
  sl.registerFactory(
      () => FavoritePageBloc(getFavoritePhotos: sl(), removeOrAddPost: sl()));

  //Use cases
  sl.registerLazySingleton(() => FetchPhotos(searchPageRepository: sl()));
  sl.registerLazySingleton(() => TransformData(transform: sl()));
  sl.registerLazySingleton(
      () => GetFavoritePhotos(favoritePageRepository: sl()));
  sl.registerLazySingleton(
      () => AddOrRemoveFavoritePost(favoritePageRepository: sl()));

  //Repositories
  sl.registerLazySingleton<SearchPageRepository>(() => SearchPageRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<FavoritePageRepository>(
    () => FavoritePageRepositoryImpl(localDataSource: sl()),
  );

  //Remote data sources
  sl.registerLazySingleton<SearchPageRemoteDataSource>(
    () => SearchPageRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  //Local data sources
  sl.registerLazySingleton<FavoritePageLocalDataSource>(
      () => FavoritePageLocalDataSourceImpl());

  //Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  //External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  //Transforms
  sl.registerLazySingleton<DetailPageDataTransform>(
      () => DetailPageDataTransformImpl());
}
