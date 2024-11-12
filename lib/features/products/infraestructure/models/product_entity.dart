
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

}
