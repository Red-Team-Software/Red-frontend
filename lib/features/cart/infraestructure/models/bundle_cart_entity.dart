import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/bundles/infraestructure/models/bundle_entity.dart';
import 'package:isar/isar.dart';

part 'bundle_cart_entity.g.dart';

@collection
class BundleCartEntity {

  Id? isarId;

  final IsarLink<BundleEntity> bundle = IsarLink<BundleEntity>();
  int quantity;

  BundleCartEntity({
    required this.quantity,
  });

  BundleCartEntity copyWith({
    Bundle? bundle,
    int? quantity,
  }) {
    return BundleCartEntity(
      quantity: quantity ?? this.quantity,
    );
  }
}