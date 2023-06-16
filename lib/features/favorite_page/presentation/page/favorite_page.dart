import 'package:flickr_test_app/features/favorite_page/presentation/widgets/favorite_page_favorite_body.dart';
import 'package:flickr_test_app/features/search_page/presentation/widgets/search_page_flex_space.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const FlexSpace(),
        title: const Text('Favorites'),
        titleTextStyle: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: const FavoriteBody(),
    );
  }
}
