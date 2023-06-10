import 'package:equatable/equatable.dart';
import 'package:flickr_test_app/features/search_page/data/model/search_page_post_model.dart';

class Photos extends Equatable {
  final int page;
  final int pages;
  final int perpage;
  final int total;
  final List<PostModel> photo;

  const Photos({
    required this.page,
    required this.pages,
    required this.perpage,
    required this.total,
    required this.photo,
  });


  @override
  List<Object?> get props =>[];

}
class Post extends Equatable {
  final String id;
  final String owner;
  final String secret;
  final String server;
  final int farm;
  final String title;
  final int ispublic;
  final int isfriend;
  final int isfamily;
  final String photoUrl;

  const Post({
    required this.id,
    required this.owner,
    required this.secret,
    required this.server,
    required this.farm,
    required this.title,
    required this.ispublic,
    required this.isfriend,
    required this.isfamily,
    required this.photoUrl
  });

  @override
  List<Object?> get props => [id];
}