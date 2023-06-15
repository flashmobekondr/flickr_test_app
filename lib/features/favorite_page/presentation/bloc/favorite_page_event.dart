import 'package:equatable/equatable.dart';
import '../../../search_page/data/model/search_page_post_model.dart';

sealed class FavoritePageEvent extends Equatable {
  const FavoritePageEvent();
  @override
  List<Object?> get props => [];
}

final class LoadFavoriteEvent extends FavoritePageEvent {}

final class AdddOrRemoveEvent extends FavoritePageEvent {
final PostModel post;

const AdddOrRemoveEvent({required this.post});

@override
List<Object?> get props => [post];

@override
String toString() => 'AddOrRemoveEvent: {post : $post}';
}