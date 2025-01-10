class Category {
  final String id;
  final String name;
  final String icon;
  final List<ItemCategory> products;
  final List<ItemCategory> bundles;

  Category(
      {required this.id,
      required this.name,
      required this.icon,
      this.products = const [],
      this.bundles = const []
      });
}

class ItemCategory {
  final String id;
  final String name;
  final String imageUrl;
  final double? price;
  ItemCategory(
      {required this.id,
      required this.name,
      required this.imageUrl,
      this.price
      });
}
