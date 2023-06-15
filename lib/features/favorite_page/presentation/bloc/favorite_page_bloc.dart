import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flickr_test_app/features/detail_page/presentation/bloc/detail_page_state.dart';
import 'package:flickr_test_app/features/favorite_page/data/datasources/favorite_page_local_data_source.dart';
import 'package:flickr_test_app/features/favorite_page/domain/usecases/favorite_page_usecase_add_delete_photos.dart';
import 'package:flickr_test_app/features/favorite_page/domain/usecases/favorite_page_usecase_get_favorite_photos.dart';
import 'package:flickr_test_app/features/favorite_page/presentation/bloc/favorite_page_event.dart';
import 'package:flickr_test_app/features/favorite_page/presentation/bloc/favorite_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../../../core/error/failures.dart';
import '../../../search_page/data/model/search_page_post_model.dart';

const throttleDuration = Duration(milliseconds: 600);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class FavoritePageBloc extends Bloc<FavoritePageEvent, FavoritePageState> {
  final GetFavoritePhotos getFavoritePhotos;
  final AddOrRemoveFavoritePost removeOrAddPost;
  FavoritePageBloc({required this.getFavoritePhotos, required this.removeOrAddPost}): super(const FavoritePageState()){
    on<LoadFavoriteEvent>(
      _onLoadFavorite,
      transformer: throttleDroppable(throttleDuration),
    );
    on<AdddOrRemoveEvent>(
      _onAddOrRemove,
      transformer: throttleDroppable(throttleDuration),
    );
  }
  
  Future<void> _onLoadFavorite (
      LoadFavoriteEvent event,
      Emitter<FavoritePageState> emit,
      ) async {
    final result = await getFavoritePhotos(action: PostAction.get);
    _extractList(result: result, emit: emit);
  }
  
  Future<void> _onAddOrRemove (
      AdddOrRemoveEvent event,
      Emitter<FavoritePageState> emit,
      ) async {
    final ({Failure? error, List<PostModel>? post}) result;
    state.posts.contains(event.post)
        ? result = await removeOrAddPost(action: PostAction.delete, post:  event.post)
        : result = await removeOrAddPost(action: PostAction.cache, post: event.post);
    _extractList(result: result, emit: emit, event: event);
  }

  void _extractList ({
        required ({Failure? error, List<PostModel>? post}) result,
        required Emitter<FavoritePageState> emit,
        AdddOrRemoveEvent? event}) {
    switch (result) {
      case (error: null, post: var post?) :
        emit(state.copyWith(posts: post, status: PostStatus.success));
      case (error: var error?, post: null) :
        emit(state.copyWith(status: PostStatus.failure));
      case (error: null, post: null) :
        emit(
            state.copyWith(
                    status: PostStatus.success,
                    posts: List.from(state.posts)..add(event!.post))
      );
    }
  }
}