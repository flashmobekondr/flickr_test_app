import 'package:flickr_test_app/features/favorite_page/data/datasources/favorite_page_local_data_source.dart';
import 'package:flickr_test_app/features/favorite_page/domain/repositories/favorite_page_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../search_page/data/model/search_page_post_model.dart';

class GetFavoritePhotos {
  final FavoritePageRepository favoritePageRepository;

  GetFavoritePhotos({required this.favoritePageRepository});

  Future<({List<PostModel>? post, Failure? error})> call(
          {required PostAction action}) async =>
      favoritePageRepository.deleteAddOrGetLocalPosts(action: action);
}
