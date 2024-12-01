part of 'search_bloc.dart';

enum SearchStatus { initial, loading, loaded, error }

class SearchState extends Equatable {

  final String query;
  final SearchStatus status;
  final List<Product> products;
  final List<Bundle> bundles;
  
  const SearchState({
    this.query = '',
    this.status = SearchStatus.initial,
    this.products = const [],
    this.bundles = const [],
  });

  @override
  List<Object> get props => [query ,status, products, bundles];

  SearchState copyWith({
    String? query,
    SearchStatus? status,
    List<Product>? products,
    List<Bundle>? bundles,
  }) {
    return SearchState(
      query: query ?? this.query,
      status: status ?? this.status,
      products: products ?? this.products,
      bundles: bundles ?? this.bundles,
    );
  }
}


class SearchInitial extends SearchState {
  const SearchInitial() : super();
}
