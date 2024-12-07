class Category {
  final String id;
  final String name;
  final String icon;
  final List<ProductCategory> products;
  Category(
      {required this.id,
      required this.name,
      required this.icon,
      this.products = const []});
}

class ProductCategory {
  final String id;
  final String name;
  final List<String> images;
  final String description;
  final double price;
  ProductCategory(
      {required this.id,
      required this.name,
      required this.images,
      required this.description,
      required this.price});
}
