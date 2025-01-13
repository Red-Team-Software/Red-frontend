import 'package:isar/isar.dart';
part 'product_entity.g.dart';

@collection
class ProductEntity {
  Id? isarId;

  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> imageUrl;
  final String? currency;
  final String? expirationDate;
  final List<String>? tags;
  final int? weigth;
  final String? measurement;

  ProductEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.expirationDate,
      this.tags,
      this.currency,
      this.weigth,
      this.measurement});

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'] as String,
      name: json['nombre'] as String,
      description: json['descripcion'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: (json['images'] as List).map((e) => e as String).toList(),
      currency: json['currency'] as String?,
    );
  }
}
