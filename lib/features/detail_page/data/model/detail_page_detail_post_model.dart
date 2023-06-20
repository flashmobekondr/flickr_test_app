import 'package:flickr_test_app/features/detail_page/domain/entities/detail_page_post.dart';
import '../../../../core/api_constants/api_constants.dart';
import '../../../search_page/domain/entities/search_page_photos.dart';

final class DetailPostModel extends DetailPost {
  const DetailPostModel(
      {required super.id,
      required super.owner,
      required super.secret,
      required super.server,
      required super.farm,
      required super.title,
      required super.ispublic,
      required super.isfriend,
      required super.isfamily,
      required super.photoUrl});

  factory DetailPostModel.searchToDetail(Post post) => DetailPostModel(
      id: post.id,
      owner: post.owner,
      secret: post.secret,
      server: post.server,
      farm: post.farm,
      title: post.title,
      ispublic: post.ispublic,
      isfriend: post.isfriend,
      isfamily: post.isfamily,
      photoUrl:
          '${ApiConstants.photoImageUrl}/${post.server}/${post.id}_${post.secret}_${SizeSuffix.medium_800}.jpg');
}
