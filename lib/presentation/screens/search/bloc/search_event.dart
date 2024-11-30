part of 'search_bloc.dart';

sealed class SearchEvent {
  const SearchEvent();
}


class CustomSearchEvent extends SearchEvent {
  final String query;
  const CustomSearchEvent({required this.query});
}

class ErrorSearchEvent extends SearchEvent {
  final String message;
  const ErrorSearchEvent(
    this.message,
  );
}

class LoadingSearchEvent extends SearchEvent {
  const LoadingSearchEvent();
}

class LoadedSearchEvent extends SearchEvent {
  const LoadedSearchEvent();
}

class ResetSearchEvent extends SearchEvent {
  const ResetSearchEvent();
}