import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/bundles/infraestructure/models/bundle_entity.dart';

class BundleEntityMapper {
  static BundleEntity mapBundleToEntity(Bundle bundle) {
    return BundleEntity(
      id: bundle.id,
      name: bundle.name,
      description: bundle.description,
      price: bundle.price,
      imageUrl: bundle.imageUrl,
      currency: bundle.currency,
    );
  }

  static Bundle mapBundleToDomain(BundleEntity entity) {
    return Bundle(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      imageUrl: entity.imageUrl,
      currency: entity.currency,
    );
  }
}
