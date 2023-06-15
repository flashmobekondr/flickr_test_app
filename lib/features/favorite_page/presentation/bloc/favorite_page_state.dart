import 'package:equatable/equatable.dart';
import 'package:flickr_test_app/features/detail_page/presentation/bloc/detail_page_state.dart';
import 'package:flickr_test_app/features/search_page/data/model/search_page_post_model.dart';

final class FavoritePageState extends Equatable {
  final List<PostModel> posts;
  final PostStatus status;

  const FavoritePageState({
    this.posts = const <PostModel>[],
    this.status = PostStatus.initial
  });

  FavoritePageState copyWith({
      List<PostModel>? posts,
      PostStatus? status,
  }) {
      return  FavoritePageState(
          posts: posts ?? this.posts,
          status: status ?? this.status
      );
}


  @override
  List<Object?> get props =>[status,posts];

  @override
  String toString() => 'FavoritePageState: {status: $status, amount: ${posts.length}';

}