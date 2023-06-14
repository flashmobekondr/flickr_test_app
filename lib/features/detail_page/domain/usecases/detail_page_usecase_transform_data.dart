import 'package:flickr_test_app/features/detail_page/domain/entities/detail_page_post.dart';

import '../../../search_page/domain/entities/search_page_photos.dart';
import '../../data/datasources/detail_page_data_transform_impl.dart';

final class TransformData {
  final DetailPageDataTransform transform;
  const TransformData({required this.transform});

  DetailPost call ({required Post post}) => transform.transformSearchPostToDetail(post);
}