import 'package:GoDeli/features/products/domain/product.dart';
import 'package:isar/isar.dart';

import '../../../products/infraestructure/models/product_entity.dart';

part 'product_cart_entity.g.dart';

@collection
class ProductCartEntity {

  Id? isarId;

  final IsarLink<ProductEntity> product = IsarLink<ProductEntity>();
  int quantity;

  ProductCartEntity({
    required this.quantity,
  });

  ProductCartEntity copyWith({
    Product? product,
    int? quantity,
  }) {
    return ProductCartEntity(
      quantity: quantity ?? this.quantity,
    );
  }
}