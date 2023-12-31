import '../../data/model/search_page_post_model.dart';

enum PhotoStatus { initial, success, failure }

final class SearchPageState {
  final List<PostModel> photos;
  final bool hasReachedMax;
  final PhotoStatus status;
  final int page;

  const SearchPageState({
    this.photos = const <PostModel>[],
    this.hasReachedMax = false,
    this.status = PhotoStatus.initial,
    this.page = 0,
  });

  SearchPageState copyWith({
    List<PostModel>? photos,
    bool? hasReachedMax,
    PhotoStatus? status,
    int? page,
  }) {
    return SearchPageState(
        photos: photos ?? this.photos,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status,
        page: page ?? this.page);
  }

  @override
  String toString() =>
      'SearchPageState {status: $status, amount: ${photos.length},page:$page, hasReachedMax: $hasReachedMax}';
}
