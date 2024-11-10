

class Product {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
  });

  Product copyWith({
    String? id,
    String? name,
    double? price,
    int? quantity,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
    );
  }
}

class Bundle {
  final String id;
  final String name;
  final double price;
  final int stock;

  Bundle({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
  });
} 

class Cart {
  final List<Product> products;
  final List<Bundle>? bundles;
  final double discount = 0.0;

  Cart({required this.products, this.bundles});
}