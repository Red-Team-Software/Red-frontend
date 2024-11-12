part of 'all_products_bloc.dart';

sealed class AllProductsEvent {
  const AllProductsEvent();
}

class ProductsFetched extends AllProductsEvent {
  final List<Product> products;
  const ProductsFetched(this.products);
}

class ProductsLoading extends AllProductsEvent {
  const ProductsLoading();
}

class ProductsIsEmpty extends AllProductsEvent {
  const ProductsIsEmpty();
}

class ProductsError extends AllProductsEvent {
  const ProductsError();
}
