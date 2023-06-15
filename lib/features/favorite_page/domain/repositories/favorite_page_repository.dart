import '../../../../core/error/failures.dart';
import '../../../search_page/data/model/search_page_post_model.dart';
import '../../../search_page/domain/entities/search_page_photos.dart';
import '../../data/datasources/favorite_page_local_data_source.dart';

abstract interface class FavoritePageRepository {
  Future<({PostModel? post, Failure? error})> getLocalPosts(Post post);
}