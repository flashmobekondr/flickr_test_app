import 'package:flickr_test_app/core/error/failures.dart';
import 'package:flickr_test_app/features/search_page/domain/entities/search_page_photos.dart';
import 'package:flickr_test_app/features/search_page/domain/repositories/search_page_repository.dart';

class GetPhotos {
  final SearchPageRepository searchPageRepository;
  GetPhotos({required this.searchPageRepository});
  Future<({Failure? error, Photos? photos})> call(
            String textQueue,
            int pageNumber
            ) async => searchPageRepository.getRemotePhotos(textQueue, pageNumber);
}