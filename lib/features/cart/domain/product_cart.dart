import 'package:GoDeli/features/products/domain/product.dart';

class ProductCart{

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
}

