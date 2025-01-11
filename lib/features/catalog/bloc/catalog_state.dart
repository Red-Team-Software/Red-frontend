part of 'catalog_bloc.dart';

enum CatalogStatus { initial, loading, loaded, error }

class CatalogState extends Equatable {

  final List<Product> products;
  final List<Bundle> bundles;
  final List<String> categorySelected;
  final CatalogStatus status;
  final int page;
  final int perPage;
  final bool popular;
  final double discount;

  const CatalogState({
    this.products = const [],  
    this.bundles = const [], 
    this.categorySelected = const [],
    this.status = CatalogStatus.initial, 
    this.page = 1,
    this.perPage = 10,
    this.popular = false,
    this.discount = 0.0
    });

  CatalogState copyWith({
    List<Product>? products,
    List<Bundle>? bundles,
    CatalogStatus? status,
    List<String>? categorySelected,
    int? page,
    int? perPage,
    bool? popular,
    double? discount
  }) {
    return CatalogState(
      products: products ?? this.products,
      bundles: bundles ?? this.bundles,
      status: status ?? this.status,
      categorySelected: categorySelected ?? this.categorySelected,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      popular: popular ?? this.popular,
      discount: discount ?? this.discount
    );
  }
  
  @override
  List<Object?> get props => [products, bundles, status, categorySelected, page, perPage, popular, discount];
}
