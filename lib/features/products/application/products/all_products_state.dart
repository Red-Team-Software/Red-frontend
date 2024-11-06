part of 'all_products_bloc.dart';

enum ProductsStatus { loading, error, loaded, allLoaded }

class AllProductsState extends Equatable {
  final List<Product> products;
  final ProductsStatus status;
  final int page;
  final int perPage;

  const AllProductsState({
    this.products = const [],
    this.status = ProductsStatus.loaded,
    this.page = 1,
    this.perPage = 10,
  });

  AllProductsState copyWith({
    List<Product>? products,
    ProductsStatus? status,
    int? page,
    int? perPage,
  }) {
    return AllProductsState(
      products: products ?? this.products,
      status: status ?? this.status,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
    );
  }

  @override
  List<Object?> get props => [products, status, page, perPage];
}
