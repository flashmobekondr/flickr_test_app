import 'package:equatable/equatable.dart';
import '../../../search_page/data/model/search_page_post_model.dart';
enum EventAction {insert,remove}
sealed class FavoritePageEvent extends Equatable {
  const FavoritePageEvent();
  @override
  List<Object?> get props => [];
}

final class LoadFavoriteEvent extends FavoritePageEvent {}

final class AdddOrRemoveEvent extends FavoritePageEvent {
  final EventAction action;
final PostModel post;

const AdddOrRemoveEvent({required this.post, required this.action});

@override
List<Object?> get props => [post];

@override
String toString() => 'AddOrRemoveEvent: {post : $post}';
}