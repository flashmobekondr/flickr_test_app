import 'package:flickr_test_app/features/detail_page/presentation/widgets/detail_page_detail_body.dart';
import 'package:flutter/material.dart';
import '../../../search_page/data/model/search_page_post_model.dart';
import '../widgets/favorite_page_button.dart';

class DetailPage extends StatelessWidget {
  final PostModel post;

  const DetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          FavoriteButton(post: post),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const DetailBody(),
    );
  }
}
