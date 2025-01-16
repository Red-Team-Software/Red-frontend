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
  final double price;
  final String term;

  const CatalogState(
      {this.products = const [],
      this.bundles = const [],
      this.categorySelected = const [],
      this.status = CatalogStatus.initial,
      this.page = 1,
      this.perPage = 10,
      this.popular = false,
      this.discount = 0.0,
      this.price = 0.0,
      this.term = ''});

  CatalogState copyWith(
      {List<Product>? products,
      List<Bundle>? bundles,
      CatalogStatus? status,
      List<String>? categorySelected,
      int? page,
      int? perPage,
      bool? popular,
      double? discount,
      double? price,
      String? term}) {
    return CatalogState(
        products: products ?? this.products,
        bundles: bundles ?? this.bundles,
        status: status ?? this.status,
        categorySelected: categorySelected ?? this.categorySelected,
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        popular: popular ?? this.popular,
        discount: discount ?? this.discount,
        price: price ?? this.price,
        term: term ?? this.term);
  }

  @override
  List<Object?> get props => [
        products,
        bundles,
        status,
        categorySelected,
        page,
        perPage,
        popular,
        discount,
        price,
        term
      ];
}
