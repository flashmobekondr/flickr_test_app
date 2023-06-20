import 'package:flickr_test_app/features/detail_page/data/model/detail_page_detail_post_model.dart';
import 'package:flickr_test_app/features/detail_page/domain/entities/detail_page_post.dart';

import 'package:flickr_test_app/features/search_page/domain/entities/search_page_photos.dart';

abstract interface class DetailPageDataTransform {
  DetailPost transformSearchPostToDetail(Post post);
}

class DetailPageDataTransformImpl implements DetailPageDataTransform {
  @override
  DetailPost transformSearchPostToDetail(Post post) =>
      DetailPostModel.searchToDetail(post);
}
