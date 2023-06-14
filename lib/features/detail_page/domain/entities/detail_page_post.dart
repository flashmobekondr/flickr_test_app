import 'package:equatable/equatable.dart';

class DetailPost extends Equatable {
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

  const DetailPost({
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