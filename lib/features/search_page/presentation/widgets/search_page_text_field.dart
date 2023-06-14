import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_page_bloc.dart';
import '../bloc/search_page_bloc_event.dart';

class SearchPageTextField extends StatelessWidget {
  final TextEditingController textController;

  const SearchPageTextField({super.key, required this.textController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (text){
        if(text.isNotEmpty) {
          BlocProvider.of<SearchPageBloc>(context).add(SearchPageTextChanged(text: text));
        }
      },
      textInputAction: TextInputAction.search,
      controller: textController,
      autocorrect: true,
      //autofocus: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        //prefix: const Icon(Icons.search),
        suffix: GestureDetector(
          onTap: _onTapClear,
          child: const Icon(Icons.clear),
        ),
        hintText: 'Search pictures...',
      ),
    );
  }

  void _onTapClear() {
    textController.clear();
  }
}
