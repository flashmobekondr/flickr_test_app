import 'package:flickr_test_app/features/detail_page/presentation/bloc/detail_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../favorite_page/presentation/bloc/favorite_page_bloc.dart';
import '../../../favorite_page/presentation/bloc/favorite_page_event.dart';
import '../../../favorite_page/presentation/bloc/favorite_page_state.dart';
import '../../../search_page/data/model/search_page_post_model.dart';

class FavoriteButton extends StatelessWidget {
  final PostModel post;
  const FavoriteButton({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritePageBloc,FavoritePageState>(
        builder: (context,state ) {
          switch (state.status) {
            case PostStatus.failure :
              return const Icon(Icons.error);
            case PostStatus.initial :
              return const Icon(Icons.star_border);
            case PostStatus.success :
              return GestureDetector(
                child: state.posts.contains(post)
                      ? const Icon(Icons.star)
                      : const Icon(Icons.star_border),
                onTap: () => BlocProvider.of<FavoritePageBloc>(context).add(AdddOrRemoveEvent(post:post)),
              );
          }
        }
    );
  }
}
