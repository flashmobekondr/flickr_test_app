import 'package:flickr_test_app/core/error/failures.dart';
import 'package:flickr_test_app/features/favorite_page/data/datasources/favorite_page_local_data_source.dart';
import 'package:flickr_test_app/features/search_page/data/model/search_page_post_model.dart';
import 'package:flickr_test_app/features/search_page/domain/entities/search_page_photos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/favorite_page_repository.dart';

class FavoritePageRepositoryImpl implements FavoritePageRepository {
  final FavoritePageLocalDataSource localDataSource;
  FavoritePageRepositoryImpl({required this.localDataSource});

  @override
  Future<({Failure? error, PostModel? post})> getLocalPosts(Post post) async => localDataSource.getLocalPosts(post);
}