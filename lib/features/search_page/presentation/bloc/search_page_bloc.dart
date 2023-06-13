import 'package:flickr_test_app/features/search_page/domain/usecases/search_page_usecase_get_photos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'search_page_bloc_event.dart';
import 'search_page_bloc_state.dart';

const throttleDuration = Duration(milliseconds: 600);
const int firstPageNumber = 1;

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  final FetchPhotos fetchPhotos;
  SearchPageBloc({required this.fetchPhotos}) : super(const SearchPageState()){
    on<SearchPageTextChanged>(
        _oneTextChangedOrRefreshed,
        transformer:throttleDroppable(throttleDuration),
    );
    on<SearchPageRefreshPage>(
        _oneTextChangedOrRefreshed,
        transformer: throttleDroppable(throttleDuration),
    );
    on<SearchPageLoadNewPage>(
        _onLoadNewPage,
        transformer:  throttleDroppable(throttleDuration),
    );
  }

  Future<void> _oneTextChangedOrRefreshed (
      SearchPageEvent event,
      Emitter<SearchPageState> emit,
      ) async {
    await _loadParticularPage(emit: emit, event: event, state: state, pageNumber: firstPageNumber, text: event.text);
  }

  Future<void> _onLoadNewPage (
      SearchPageLoadNewPage event,
      Emitter<SearchPageState> emit,
      ) async {
    final int newPageNumber = state.page +1;
    await _loadParticularPage(emit: emit, event: event, state: state, pageNumber:newPageNumber, text: event.text);
  }

  Future<void> _loadParticularPage ({
        required Emitter<SearchPageState> emit,
        required SearchPageEvent event,
        required SearchPageState state,
        required int pageNumber,
        required String text
  }) async {
    if (state.hasReachedMax) return;
    final result = await fetchPhotos(pageNumber: pageNumber,textQueue: event.text);
    switch (result) {
      case (error: null, photos: var photos?):
        photos.photo.isEmpty
            ? emit(state.copyWith(hasReachedMax: true))
            : emit(
                state.copyWith(
              status: PhotoStatus.success,
              hasReachedMax: false,
              photos:state.photos + photos.photo,
              //photos: photos.photo,
              page: pageNumber,
          ),
        );
      case (error: var error?, photos: null) :
        emit(state.copyWith(status: PhotoStatus.failure));
    }
  }
}