

class Category {
  final String id;
  final String name;
  final String icon;
  final List<ProductCategory> products;
  Category({required this.id, required this.name, required this.icon, this.products = const []});
}

class ProductCategory{
  final String id;
  final String name;
  final List<String> images;
  ProductCategory({required this.id, required this.name, required this.images});
}