part of 'popular_products_bloc.dart';

class PopularProductsState{ }

final class PopularProductsLoading extends PopularProductsState {}

final class PopularProductsLoaded extends PopularProductsState {
  final List<Product> products;

  PopularProductsLoaded(this.products);
}

final class PopularProductsError extends PopularProductsState {
  final String message;

  PopularProductsError(this.message);
}
