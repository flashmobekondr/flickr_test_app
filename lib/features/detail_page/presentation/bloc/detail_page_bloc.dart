import 'package:flickr_test_app/features/detail_page/domain/usecases/detail_page_usecase_transform_data.dart';
import 'package:flickr_test_app/features/detail_page/presentation/bloc/detail_page_event.dart';
import 'package:flickr_test_app/features/detail_page/presentation/bloc/detail_page_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPageBloc extends Bloc<DetailPageEvent, DetailPageState> {
  final TransformData transformData;

  DetailPageBloc({required this.transformData})
      : super(const DetailPageState()) {
    on<DetailPageGetDetail>(_onGetDetailPost);
  }

  Future<void> _onGetDetailPost(
    DetailPageGetDetail event,
    Emitter<DetailPageState> emit,
  ) async {
    try {
      final result = transformData(post: event.post);
      emit(state.copyWith(status: PostStatus.success, post: result));
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
