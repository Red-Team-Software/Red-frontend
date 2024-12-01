import 'dart:async';

import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/bundles/domain/repositories/bundle_repository.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/features/products/domain/repositories/products_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IProductsRepository productsRepository;
  final IBundleRepository bundleRepository;

  SearchBloc(this.productsRepository, this.bundleRepository)
      : super(const SearchInitial()) {
      on<SearchQueryChangedEvent>(_onSearchChange);
      on<ErrorSearchEvent>(_onErrorSearch);
      on<LoadingSearchEvent>(_onLoadingSearch);
      on<LoadedSearchEvent>(_onLoadedSearch);
      on<ResetSearchEvent>(_onResetSearch);
    }
  
  void _onResetSearch(ResetSearchEvent event, Emitter<SearchState> emit) {
    emit(const SearchInitial());
  }
  
  void _onLoadedSearch(LoadedSearchEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(status: SearchStatus.loaded, products: event.products, bundles: event.bundles));
  }

  void _onErrorSearch(ErrorSearchEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(status: SearchStatus.error));
  }

  void _onLoadingSearch(LoadingSearchEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(status: SearchStatus.loading));
  }

  void _onSearchChange(SearchQueryChangedEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(query: event.query));
  }

  FutureOr<void> onSearch(String? query) async {
    if (query == null || query.isEmpty || query == state.query) {
      add(const ResetSearchEvent());
      return;
    }
    add(SearchQueryChangedEvent(query));
    add(const LoadingSearchEvent());

    final productsRes = await productsRepository.searchProducts(term: query);

    if (productsRes.isSuccessful()) {

      final products = productsRes.getValue();
      add(LoadedSearchEvent(products: products, bundles: []));
      print('Products state: ${state.products}');
      
    } else {
      add(ErrorSearchEvent(productsRes.getError().toString()));
    }
  }
}
  
