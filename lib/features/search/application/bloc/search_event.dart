part of 'search_bloc.dart';

sealed class SearchEvent {
  const SearchEvent();
}

class SearchQueryChangedEvent extends SearchEvent {
  final String query;
  const SearchQueryChangedEvent(
    this.query,
  );
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
  final List<Product> products;
  final List<Bundle> bundles;
  const LoadedSearchEvent({
    required this.products,
    required this.bundles,
  });
}

class ResetSearchEvent extends SearchEvent {
  const ResetSearchEvent();
}