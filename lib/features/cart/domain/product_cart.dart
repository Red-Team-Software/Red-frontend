import 'package:GoDeli/features/products/domain/product.dart';

class ProductCart {
  final Product product;
  final int quantity;

  ProductCart({
    required this.product,
    required this.quantity,
  });

  ProductCart copyWith({
    Product? product,
    int? quantity,
  }) {
    return ProductCart(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  factory ProductCart.fromJson(Map<String, dynamic> json) {
    return ProductCart(
      product: Product(
        id: json['id'] as String,
        name: (json['nombre'] ?? json['name']) as String,
        description: json['descripcion'] as String,
        price: (json['price'] as num).toDouble(),
        imageUrl: List<String>.from(json['images'] ?? []),
        currency: json['currency'] as String?,
      ),
      quantity: json['quantity'] as int,
    );
  }
}
