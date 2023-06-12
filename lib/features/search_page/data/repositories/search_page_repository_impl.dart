import 'package:flickr_test_app/core/error/failures.dart';
import 'package:flickr_test_app/core/network/network_info.dart';
import 'package:flickr_test_app/features/search_page/data/datasources/search_page_remote_data_source.dart';
import 'package:flickr_test_app/features/search_page/domain/entities/search_page_photos.dart';
import 'package:flickr_test_app/features/search_page/domain/repositories/search_page_repository.dart';

import '../model/search_page_photos_model.dart';

class SearchPageRepositoryImpl implements SearchPageRepository {
  final SearchPageRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SearchPageRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo
  });

  @override
  Future<({Failure? error, Photos? photos})> getRemotePhotos(String textQueue, int pageNumber) async{
    if (await networkInfo.isConnected) {
      print('newtwork connected');
      return await remoteDataSource.fetchRemotePhotos(textQueue, pageNumber);
    }
    else {
      final error = ServerFailure();
      final ({Failure? error, Photos? photos}) errorResult = (error: error,photos:  null);
      return errorResult;
    }
  }

}