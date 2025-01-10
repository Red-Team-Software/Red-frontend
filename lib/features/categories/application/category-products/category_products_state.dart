part of 'category_products_bloc.dart';


enum CategoryProductsStatus { initial, loading, loaded, error }

class CategoryProductsState extends Equatable {

  final CategoryProductsStatus status;
  final List<ProductCategory> products;
  final String? selectedCategory;


  const CategoryProductsState({this.status = CategoryProductsStatus.initial, this.products = const [], this.selectedCategory});


  CategoryProductsState copyWith({
    CategoryProductsStatus? status,
    List<ProductCategory>? products,
    String? selectedCategory,
  }) {
    return CategoryProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
  
  @override
  List<Object?> get props => [status, products, selectedCategory];
}

