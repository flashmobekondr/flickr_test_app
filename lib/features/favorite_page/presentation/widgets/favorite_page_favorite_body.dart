import 'package:flickr_test_app/features/detail_page/presentation/bloc/detail_page_state.dart';
import 'package:flickr_test_app/features/favorite_page/presentation/bloc/favorite_page_bloc.dart';
import 'package:flickr_test_app/features/favorite_page/presentation/bloc/favorite_page_state.dart';
import 'package:flickr_test_app/features/favorite_page/presentation/widgets/favorite_page_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBody extends StatelessWidget {
  const FavoriteBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritePageBloc, FavoritePageState>(
        builder: (context, state) {
      switch (state.status) {
        case PostStatus.initial:
          return const Center(child: Text('No post yet'));
        case PostStatus.failure:
          return const Center(child: Text('Error :Can not load posts'));
        case PostStatus.success:
          return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return ListItem(post: state.posts[index]);
              });
      }
    });
  }
}
