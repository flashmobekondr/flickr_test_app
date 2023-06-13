import 'package:equatable/equatable.dart';
import 'package:flickr_test_app/features/search_page/domain/entities/search_page_photos.dart';

import '../../data/model/search_page_post_model.dart';

enum PhotoStatus {initial, success, failure}
// class SearchPageInitialState extends SearchPageState {}
// class SearchPageLoadingState extends SearchPageState {}
//class SearchPageErrorState extends SearchPageState {}

class SearchPageState extends Equatable {
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
        page: page ?? this.page
    );
  }
  @override
  List<Object?> get props => [photos,status, page, hasReachedMax];

  @override
  String toString() => 'SearchPageState {status: $status, amount: ${photos.length},page:$page, hasReachedMax: $hasReachedMax}';
}
