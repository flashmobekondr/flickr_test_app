import 'package:flickr_test_app/core/error/failures.dart';
import 'package:flickr_test_app/features/search_page/domain/entities/search_page_photos.dart';

abstract class SearchPageRepository {
  Future<({List<Photos> photos,Failure error})> getRemotePhotos(String textQueue, int pageNumber);
}