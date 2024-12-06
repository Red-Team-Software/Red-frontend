part of 'category_products_bloc.dart';

sealed class CategoryProductsEvent {
  const CategoryProductsEvent();
}

class FetchProducts extends CategoryProductsEvent {
  final String categoryId;
  const FetchProducts(this.categoryId);
}

class CategoryChanged extends CategoryProductsEvent {
  final String categoryId;
  const CategoryChanged(this.categoryId);
}

class ProductsFetched extends CategoryProductsEvent {
  final List<ProductCategory> products;
  const ProductsFetched(this.products);
}

class ProductsLoading extends CategoryProductsEvent {
  const ProductsLoading();
}

class ProductsIsEmpty extends CategoryProductsEvent {
  const ProductsIsEmpty();
}

class ProductsError extends CategoryProductsEvent {
  const ProductsError();
}