import 'package:flickr_test_app/core/error/failures.dart';
import 'package:flickr_test_app/features/favorite_page/data/datasources/favorite_page_local_data_source.dart';
import 'package:flickr_test_app/features/search_page/data/model/search_page_post_model.dart';
import '../../domain/repositories/favorite_page_repository.dart';

class FavoritePageRepositoryImpl implements FavoritePageRepository {
  final FavoritePageLocalDataSource localDataSource;
  FavoritePageRepositoryImpl({required this.localDataSource});

  @override
  Future<({Failure? error, List<PostModel>? post})> deleteAddOrGetLocalPosts({PostModel? post, required PostAction action}) async {
    try {
      final result =  await localDataSource.deleteAddOrGetLocalPosts(action: action, post: post);
      switch (result) {
        case var list? :
          return (error: null, post: list); // if List<PostModel> is NOT null and there`s no any exceptions
        default :
          return (error: null, post : null); // if insert/delete operations were success and there`s no any exceptions
      }
    } catch (_) { // capture rethrow from localDataSource
      return (error: CacheFailure(),post: null);
    }
  }
}