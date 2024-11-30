part of 'search_bloc.dart';

enum SearchStatus { initial, loading, loaded, error }

class SearchState extends Equatable {

  final SearchStatus status;
  final List<Product> products;
  final List<Bundle> bundles;
  
  const SearchState({
    this.status = SearchStatus.initial,
    this.products = const [],
    this.bundles = const [],
  });

  @override
  List<Object> get props => [status, products, bundles];

  SearchState copyWith({
    SearchStatus? status,
    List<Product>? products,
    List<Bundle>? bundles,
  }) {
    return SearchState(
      status: status ?? this.status,
      products: products ?? this.products,
      bundles: bundles ?? this.bundles,
    );
  }
}


class SearchInitial extends SearchState {
  const SearchInitial() : super();
}
