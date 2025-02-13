part of 'catalog_bloc.dart';

sealed class CatalogEvent {
  const CatalogEvent();
}


class ItemsFetched extends CatalogEvent {
  final List<Product> product;
  final List<Bundle> bundle;
  final bool isPagination;

  const ItemsFetched(this.product, this.bundle, {this.isPagination = false});
}

class CategorySet extends CatalogEvent {
  final String category;
  const CategorySet(this.category);
}

class PopularSet extends CatalogEvent {
  final bool? popular;
  const PopularSet({this.popular});
}

class DiscountSet extends CatalogEvent {
  final double discount;
  DiscountSet(double discount) : discount = double.parse(discount.toStringAsFixed(2));
}

class PriceSet extends CatalogEvent {
  final double price;
  PriceSet(double price) : price = double.parse(price.toStringAsFixed(2));
}

class TermSet extends CatalogEvent {
  final String term;
  const TermSet(this.term);
}

class PageSet extends CatalogEvent {
  final int page;
  const PageSet(this.page);
}

class PerPageSet extends CatalogEvent {
  final int perPage;
  const PerPageSet(this.perPage);
}

class CatalogLoading extends CatalogEvent {
  const CatalogLoading();
}

class CatalogIsEmpty extends CatalogEvent {
  const CatalogIsEmpty();
}

class CatalogError extends CatalogEvent {
  final String error;
  const CatalogError(this.error);
}

class FetchItems extends CatalogEvent {
  final bool isPagination;

  const FetchItems({this.isPagination = false});
}
class CategoryListSet extends CatalogEvent {
  final List<String> category;
  const CategoryListSet(this.category);
}