
import 'package:GoDeli/features/products/domain/product.dart';

class ProductCart extends Product {
  final int quantity;

  ProductCart({
    required super.id,
    required super.name,
    required super.price,
    required this.quantity,
    required super.description,
    required super.imageUrl,
  });


  ProductCart copyWith({
    String? id,
    String? name,
    double? price,
    int? quantity,
    String? description,
    List<String>? imageUrl,
  }) {
    return ProductCart(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [id, name, price, quantity, description, imageUrl];
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
