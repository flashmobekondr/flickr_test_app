import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../detail_page/presentation/bloc/detail_page_bloc.dart';
import '../../../detail_page/presentation/bloc/detail_page_event.dart';
import '../../../detail_page/presentation/pages/detail_page.dart';
import '../../../search_page/data/model/search_page_post_model.dart';

class ListItem extends StatelessWidget {
  final PostModel post;

  const ListItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        BlocProvider.of<DetailPageBloc>(context)
            .add(DetailPageGetDetail(post: post));
        return DetailPage(post: post);
      })),
      child: Center(
        child: Container(
          height: screenSize.height / 4,
          width: screenSize.width,
          margin: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(post.photoUrl))),
        ),
      ),
    );
  }
}
