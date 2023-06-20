import 'package:equatable/equatable.dart';

sealed class SearchPageEvent extends Equatable {
  final String text;

  const SearchPageEvent({required this.text});
}

//Load first page with results depends on input text
final class SearchPageTextChanged extends SearchPageEvent {
  const SearchPageTextChanged({required super.text});

  @override
  List<Object?> get props => [text];

  @override
  String toString() => 'TextChanged: {text: $text}';
}

//Refresh page with current text
final class SearchPageRefreshPage extends SearchPageEvent {
  const SearchPageRefreshPage({required super.text});

  @override
  List<Object?> get props => [text];

  @override
  String toString() => 'PageRefresh: {text : $text}';
}

//Load one more page when scroll reached the bottom
final class SearchPageLoadNewPage extends SearchPageEvent {
  const SearchPageLoadNewPage({required super.text});

  @override
  List<Object?> get props => [text];

  @override
  String toString() => 'LoadNewPage: {text : $text}';
}
