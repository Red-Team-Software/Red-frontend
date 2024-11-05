
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> imageUrl;
  final String? expirationDate;
  final List<String>? tags;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.expirationDate,
    this.tags,
  });
}