import 'package:flickr_test_app/features/search_page/presentation/widgets/search_page_flex_space.dart';
import 'package:flickr_test_app/features/search_page/presentation/widgets/search_page_grid_item.dart';
import 'package:flickr_test_app/features/search_page/presentation/widgets/search_page_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../favorite_page/presentation/page/favorite_page.dart';
import '../bloc/search_page_bloc.dart';
import '../bloc/search_page_bloc_event.dart';
import '../bloc/search_page_bloc_state.dart';
import '../widgets/search_page_bottom_loader.dart';

enum GridColumns { one, two, four }

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  int _crossAxisCount = 2;
  GridColumns _gridViewType = GridColumns.two;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: _moveToFavorites,
          ),
          IconButton(
            icon: _columnIcon,
            onPressed: _switchView,
          ),
        ],
        flexibleSpace: const FlexSpace(),
        title: SearchPageTextField(
          textController: _textController,
        ),
      ),
      body: BlocBuilder<SearchPageBloc, SearchPageState>(
        builder: (context, state) {
          switch (state.status) {
            case PhotoStatus.failure:
              return const Center(child: Text('failed to fetch photos'));
            case PhotoStatus.initial:
              return const Center(child: Text('Explore pictures you want'));
            case PhotoStatus.success:
              if (state.photos.isEmpty) {
                return const Center(child: Text('no posts'));
              }
              return RefreshIndicator(
                onRefresh: _refreshState,
                child: GridView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _crossAxisCount,
                    ),
                    itemCount:
                        (state.hasReachedMax || _textController.text.isEmpty)
                            ? state.photos.length
                            : state.photos.length + 1,
                    itemBuilder: (context, index) {
                      return index >= state.photos.length
                          ? const BottomLoader()
                          : GridItem(state: state.photos[index]);
                    }),
              );
          }
        },
      ),
    );
  }

  void _moveToFavorites() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const FavoritePage();
    }));
  }

  Widget get _columnIcon {
    switch (_gridViewType) {
      case GridColumns.one:
        return const Icon(Icons.view_agenda);
      case GridColumns.two:
        return const Icon(Icons.view_column);
      case GridColumns.four:
        return const Icon(Icons.view_comfortable);
    }
  }

  void _switchView() {
    switch (_gridViewType) {
      case GridColumns.one:
        _crossAxisCount = 2;
        _gridViewType = GridColumns.two;
      case GridColumns.two:
        _crossAxisCount = 4;
        _gridViewType = GridColumns.four;
      case GridColumns.four:
        _crossAxisCount = 1;
        _gridViewType = GridColumns.one;
    }
    setState(() {});
  }

  bool get _currentTextIsNotNull {
    return _textController.text.isNotEmpty;
  }

  Future<void> _refreshState() async {
    if (_currentTextIsNotNull) {
      final block = BlocProvider.of<SearchPageBloc>(context).stream.first;
      BlocProvider.of<SearchPageBloc>(context)
          .add(SearchPageRefreshPage(text: _textController.text));
      await block;
    }
  }

  void _onScroll() {
    if (_isBottom && _currentTextIsNotNull) {
      BlocProvider.of<SearchPageBloc>(context)
          .add(SearchPageLoadNewPage(text: _textController.text));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
