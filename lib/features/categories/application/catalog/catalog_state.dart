part of 'catalog_bloc.dart';

enum CatalogStatus { initial, loading, loaded, error }

class CatalogState extends Equatable {

  final List<ItemCategory> products;
  final List<ItemCategory> bundles;
  final CatalogStatus status;
  final String? categorySelected;
  final int page;
  final int perPage;

  const CatalogState({
    this.products = const [],  
    this.bundles = const [], 
    this.status = CatalogStatus.initial, 
    this.page = 1,
    this.perPage = 10,
    this.categorySelected
    });

  CatalogState copyWith({
    List<ItemCategory>? products,
    List<ItemCategory>? bundles,
    CatalogStatus? status,
    String? categorySelected,
    int? page,
    int? perPage
  }) {
    return CatalogState(
      products: products ?? this.products,
      bundles: bundles ?? this.bundles,
      status: status ?? this.status,
      categorySelected: categorySelected ?? this.categorySelected,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage
    );
  }
  
  @override
  List<Object?> get props => [products, bundles, status, categorySelected, page, perPage];
}
