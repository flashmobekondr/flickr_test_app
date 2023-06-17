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
      style: const TextStyle(
        fontSize: 20.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      onSubmitted: (text){
        if(text.isNotEmpty) {
          BlocProvider.of<SearchPageBloc>(context).add(SearchPageTextChanged(text: text));
        }
      },
      textInputAction: TextInputAction.search,
      controller: textController,
      decoration: InputDecoration(
        label: const Icon(Icons.search),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: const EdgeInsets.only(
            left: 15.0,
            right:15.0,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white60,
              width: 3,
            )
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none
        ),
        suffix: GestureDetector(
          onTap: _onTapClear,
          child: const Icon(
            Icons.clear,
            size: 20,
          ),
        ),
        hintText: 'Search pictures...',
        hintStyle: const TextStyle(
          fontSize: 20.0,
          color: Colors.white54,
        ),
      ),
    );
  }

  void _onTapClear() {
    textController.text.isNotEmpty
      ? textController.clear()
      : FocusManager.instance.primaryFocus?.unfocus();
  }
}
