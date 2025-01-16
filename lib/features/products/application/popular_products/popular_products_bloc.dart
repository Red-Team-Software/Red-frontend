import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/features/products/domain/repositories/products_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'popular_products_event.dart';
part 'popular_products_state.dart';

class PopularProductsBloc extends Bloc<PopularProductsEvent, PopularProductsState> {
  
  final IProductsRepository productsRepository;

  
  PopularProductsBloc({
    required this.productsRepository,
  }) : super(PopularProductsState()) {
    on<FetchPopularProducts>(_onFetchPopularProducts);
    add(FetchPopularProducts());
  }

  void _onFetchPopularProducts(FetchPopularProducts event, Emitter<PopularProductsState> emit) async {
    emit(PopularProductsLoading());
    final res = await productsRepository.getProducts(page: 1, perPage: 5, popular: 'true');
    if (!res.isSuccessful()) {
      emit(PopularProductsError('Failed to get popular products'));
      return;
    }
    emit(PopularProductsLoaded(res.getValue()));
  }
}
