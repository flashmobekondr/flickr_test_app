import 'package:equatable/equatable.dart';

import '../../../search_page/domain/entities/search_page_photos.dart';

sealed class DetailPageEvent extends Equatable {
  final Post post;
  const DetailPageEvent({required this.post});
}
final class DetailPageGetDetail extends DetailPageEvent {
  const DetailPageGetDetail({required super.post});

  @override
  List<Object?> get props => [post];

@override
String toString() => 'DetailPageGetPost: {post: $post}';
}