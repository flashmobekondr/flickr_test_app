import 'package:flickr_test_app/features/search_page/domain/entities/search_page_photos.dart';
import 'package:flickr_test_app/core/api_constants/api_constants.dart';

class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.owner,
    required super.secret,
    required super.server,
    required super.farm,
    required super.title,
    required super.ispublic,
    required super.isfriend,
    required super.isfamily,
    required super.photoUrl
  });

  //factory PostModel.fromRawJson(String str) => PostModel.fromJson(json.decode(str));
  //String toRawJson() => json.encode(toJson());

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        owner: json["owner"],
        secret: json["secret"],
        server: json["server"],
        farm: json["farm"],
        title: json["title"],
        ispublic: json["ispublic"],
        isfriend: json["isfriend"],
        isfamily: json["isfamily"],
        photoUrl: '${ApiConstants.photoImageUrl}/${json["server"]}/${json["id"]}_${json["secret"]}_${SizeSuffix.small_400}.jpg'
  );

  factory PostModel.fromMap(Map<String, dynamic> map) => PostModel(
        id: map["id"].toString(),
        owner: map["owner"],
        secret: map["secret"],
        server: map["server"],
        farm: map["farm"],
        title: map["title"],
        ispublic: map["ispublic"],
        isfriend: map["isfriend"],
        isfamily: map["isfamily"],
        photoUrl: '${ApiConstants.photoImageUrl}/${map["server"]}/${map["id"]}_${map["secret"]}_${SizeSuffix.small_400}.jpg'
        );

  Map<String, dynamic> toMap() => {
      "id": id,
      "owner": owner,
      "secret": secret,
      "server": server,
      "farm": farm,
      "title": title,
      "ispublic": ispublic,
      "isfriend": isfriend,
      "isfamily": isfamily,
  };

}


