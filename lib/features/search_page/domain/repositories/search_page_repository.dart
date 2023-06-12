import 'package:flickr_test_app/core/error/failures.dart';
import 'package:flickr_test_app/features/search_page/domain/entities/search_page_photos.dart';

import '../../data/model/search_page_photos_model.dart';

abstract interface class SearchPageRepository {
  Future<({Photos? photos,Failure? error})> getRemotePhotos(String textQueue, int pageNumber);
}