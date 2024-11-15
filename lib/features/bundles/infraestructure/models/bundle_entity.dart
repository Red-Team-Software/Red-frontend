import 'package:isar/isar.dart';

part 'bundle_entity.g.dart';

@collection
class BundleEntity {
  Id? isarId;

  final String id;
  final String name;
  final String description;
  final List<String> imageUrl;
  final double price;
  final String currency;
  final int? weigth;
  final String? measurement;

  BundleEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.price,
      required this.currency,
      this.weigth,
      this.measurement});

  factory BundleEntity.fromJson(Map<String, dynamic> json) {
    return BundleEntity(
      id: json['id'] as String,
      name: json['nombre'] as String,
      description: json['descripcion'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      imageUrl: (json['images'] as List).map((e) => e as String).toList(),
    );
  }
}
