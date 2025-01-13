import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/features/products/domain/repositories/products_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

const initialProduct =
    Product(id: '', name: '', description: '', price: 0, imageUrl: ['']);

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final IProductsRepository productsRepository;

  ProductDetailsBloc({required this.productsRepository})
      : super(const ProductDetailsState(product: initialProduct)) {
    on<ProductLoaded>(_onProductLoaded);
    on<LoadingStarted>(_onLoadingStarted);
    on<ErrorOnProductLoading>(_onErrorOnProductLoading);
  }

  void _onProductLoaded(
      ProductLoaded event, Emitter<ProductDetailsState> emit) {
    emit(state.copyWith(
        status: ProductDetailsStatus.loaded, product: event.product));
  }

  void _onLoadingStarted(
      LoadingStarted event, Emitter<ProductDetailsState> emit) {
    emit(state.copyWith(status: ProductDetailsStatus.loading));
  }

  void _onErrorOnProductLoading(
      ErrorOnProductLoading event, Emitter<ProductDetailsState> emit) {
    emit(state.copyWith(status: ProductDetailsStatus.error));
  }

  Future<void> getProductById(String id) async {
    if (state.status == ProductDetailsStatus.loading) return;
    add(LoadingStarted());
    final res = await productsRepository.getProductById(id);

    if (res.isSuccessful()) {
      final product = res.getValue();
      add(ProductLoaded(product: product));
      return;
    }
    print('Error es ${res.getError()}');
    add(ErrorOnProductLoading());
    return;
  }
}
