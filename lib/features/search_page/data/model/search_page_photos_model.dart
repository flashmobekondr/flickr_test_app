import 'package:flickr_test_app/features/search_page/domain/entities/search_page_photos.dart';
import 'package:flickr_test_app/features/search_page/data/model/search_page_post_model.dart';

class PhotosModel extends Photos {
  const PhotosModel(
      {required super.page,
      required super.pages,
      required super.perpage,
      required super.total,
      required super.photo});

  factory PhotosModel.fromJson(Map<String, dynamic> json) => PhotosModel(
        page: json["page"],
        pages: json["pages"],
        perpage: json["perpage"],
        total: json["total"],
        photo: List<PostModel>.from(
            json["photo"].map((x) => PostModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "pages": pages,
        "perpage": perpage,
        "total": total,
        "photo": List<dynamic>.from(photo.map((x) => x.toMap())),
      };
}
