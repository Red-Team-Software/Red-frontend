import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/features/products/domain/repositories/products_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_products_event.dart';
part 'all_products_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  final IProductsRepository productsRepository;

  AllProductsBloc({required this.productsRepository})
      : super(const AllProductsState()) {
    on<ProductsFetched>(_onProductsFetched);
    on<ProductsLoading>(_onProductsLoading);
    on<ProductsIsEmpty>(_onProductsIsEmpty);
    on<ProductsError>(_onProductsError);
  }

  void _onProductsFetched(
      ProductsFetched event, Emitter<AllProductsState> emit) {
    emit(state.copyWith(
      products: event.products,
      status: ProductsStatus.loaded,
    ));
  }

  void _onProductsIsEmpty(
      ProductsIsEmpty event, Emitter<AllProductsState> emit) {
    emit(state.copyWith(
      status: ProductsStatus.allLoaded,
    ));
  }

  void _onProductsLoading(
      ProductsLoading event, Emitter<AllProductsState> emit) {
    emit(state.copyWith(
      status: ProductsStatus.loading,
    ));
  }

  void _onProductsError(ProductsError event, Emitter<AllProductsState> emit) {
    emit(state.copyWith(
      status: ProductsStatus.error,
    ));
  }

  Future<void> fetchProductsPaginated() async {
    if (state.status == ProductsStatus.allLoaded ||
        state.status == ProductsStatus.loading ||
        state.status == ProductsStatus.error) return;
    add(const ProductsLoading());

    final res = await productsRepository.getProducts(
      page: state.page,
      perPage: state.perPage,
    );

    if (res.isSuccessful()) {
      final products = res.getValue();
      if (products.isEmpty) {
        add(const ProductsIsEmpty());
        return;
      }
      add(ProductsFetched(products));
      return;
    } else {
      add(const ProductsError());
    }
  }
}
