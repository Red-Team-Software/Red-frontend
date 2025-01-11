part of 'catalog_bloc.dart';

sealed class CatalogEvent {
  const CatalogEvent();
}


class ItemsFetched extends CatalogEvent {
  final List<ItemCategory> product;
  final List<ItemCategory> bundle;
  const ItemsFetched(this.product, this.bundle);
}

class CategorySet extends CatalogEvent {
  final String category;
  const CategorySet(this.category);
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
