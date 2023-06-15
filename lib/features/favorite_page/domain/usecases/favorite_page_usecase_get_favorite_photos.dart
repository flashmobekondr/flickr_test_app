import 'package:flickr_test_app/features/favorite_page/domain/repositories/favorite_page_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../search_page/data/model/search_page_post_model.dart';
import '../../../search_page/domain/entities/search_page_photos.dart';

class GetFavoritePhotos {
  final FavoritePageRepository favoritePageRepository;
  GetFavoritePhotos({required this.favoritePageRepository});

  Future<({PostModel? post, Failure? error})> call ({
    required Post post}) async => favoritePageRepository.getLocalPosts(post);
}