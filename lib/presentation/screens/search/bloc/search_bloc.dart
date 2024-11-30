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
      on<CustomSearchEvent>(_onSubmit);
      on<ErrorSearchEvent>((event, emit) => state.copyWith(status: SearchStatus.error));
      on<LoadingSearchEvent>((event, emit) => state.copyWith(status: SearchStatus.loading));
      on<LoadedSearchEvent>((event, emit) => state.copyWith(status: SearchStatus.loaded, products: [], bundles: []));
      on<ResetSearchEvent>((event, emit) => state.copyWith(products: [], bundles: []));
    }

  Future<void> _onSubmit(CustomSearchEvent event, Emitter<SearchState> emit) async {
    
    add(const LoadingSearchEvent());
    
    final reqP = await productsRepository.searchProducts(term: event.query);


    if(reqP.isSuccessful()){
      final products = reqP.getValue();
      emit(state.copyWith(products: products));
      add(const LoadedSearchEvent());
    }else{
      add(ErrorSearchEvent(reqP.getError().toString()));
    }
  }

  }
