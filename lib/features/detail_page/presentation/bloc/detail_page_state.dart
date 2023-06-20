import 'package:equatable/equatable.dart';
import '../../domain/entities/detail_page_post.dart';

enum PostStatus { initial, success, failure }

final class DetailPageState extends Equatable {
  final DetailPost post;
  final PostStatus status;
  const DetailPageState(
      {this.status = PostStatus.initial,
      this.post = const DetailPost(
          id: '',
          owner: '',
          secret: '',
          server: '',
          farm: 0,
          title: '',
          ispublic: 0,
          isfriend: 0,
          isfamily: 0,
          photoUrl: '')});

  DetailPageState copyWith({DetailPost? post, PostStatus? status}) {
    return DetailPageState(
        post: post ?? this.post, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [post];

  @override
  String toString() => 'DetailPageState: {$post}';
}
