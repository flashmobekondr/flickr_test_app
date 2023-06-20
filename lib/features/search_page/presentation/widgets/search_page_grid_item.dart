import 'package:flickr_test_app/features/detail_page/presentation/bloc/detail_page_bloc.dart';
import 'package:flickr_test_app/features/detail_page/presentation/bloc/detail_page_event.dart';
import 'package:flickr_test_app/features/search_page/data/model/search_page_post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../detail_page/presentation/pages/detail_page.dart';

class GridItem extends StatelessWidget {
  final PostModel state;

  const GridItem({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
          onTap: () {
            FocusScope.of(context).hasFocus
                ? FocusScope.of(context).unfocus()
                : Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                    BlocProvider.of<DetailPageBloc>(context)
                        .add(DetailPageGetDetail(post: state));
                    return DetailPage(post: state);
                  }));
          },
          child: Container(
            margin: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(state.photoUrl))),
          )),
    );
  }
}
