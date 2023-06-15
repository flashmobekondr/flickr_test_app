import 'package:flickr_test_app/core/error/failures.dart';
import 'package:flickr_test_app/features/search_page/domain/entities/search_page_photos.dart';
import 'package:flickr_test_app/features/search_page/domain/repositories/search_page_repository.dart';

class FetchPhotos {
  final SearchPageRepository searchPageRepository;
  FetchPhotos({required this.searchPageRepository});
  Future<({Failure? error, Photos? photos})> call({
            required String textQueue,
            required int pageNumber
            }) async => searchPageRepository.getRemotePhotos(textQueue, pageNumber);
}