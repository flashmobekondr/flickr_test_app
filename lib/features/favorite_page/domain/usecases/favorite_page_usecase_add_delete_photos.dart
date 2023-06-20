import '../../../../core/error/failures.dart';
import '../../../search_page/data/model/search_page_post_model.dart';
import '../../data/datasources/favorite_page_local_data_source.dart';
import '../repositories/favorite_page_repository.dart';

class AddOrRemoveFavoritePost {
  final FavoritePageRepository favoritePageRepository;

  AddOrRemoveFavoritePost({required this.favoritePageRepository});

  Future<({List<PostModel>? post, Failure? error})> call({
    required PostAction action,
    required PostModel post,
  }) async =>
      favoritePageRepository.deleteAddOrGetLocalPosts(
          post: post, action: action);
}
