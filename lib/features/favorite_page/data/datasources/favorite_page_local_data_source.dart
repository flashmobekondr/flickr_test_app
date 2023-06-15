import 'package:flickr_test_app/core/error/failures.dart';
import 'package:flickr_test_app/features/search_page/data/model/search_page_post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../search_page/domain/entities/search_page_photos.dart';

abstract interface class FavoritePageLocalDataSource {
  Future<({PostModel? post, Failure? error})> getLocalPosts (Post post);
}

class FavoritePageLocalDataSourceImpl implements FavoritePageLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavoritePageLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<({Failure? error, PostModel? post})> getLocalPosts(Post post) async{
   throw Exception();
  }

}