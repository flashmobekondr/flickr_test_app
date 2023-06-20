import 'package:flickr_test_app/features/detail_page/presentation/bloc/detail_page_bloc.dart';
import 'package:flickr_test_app/features/detail_page/presentation/bloc/detail_page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';

class DetailBody extends StatelessWidget {
  const DetailBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(child: Text('failed to fetch photo'));
          case PostStatus.initial:
            return const Center(child: Text('...'));
          case PostStatus.success:
            return PhotoView(
              enablePanAlways: true,
              imageProvider: NetworkImage(state.post.photoUrl),
            );
        }
      },
    );
  }
}
