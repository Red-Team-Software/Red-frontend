import 'package:GoDeli/features/bundles/infraestructure/mappers/bundle_entity_mapper.dart';
import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:GoDeli/features/cart/infraestructure/models/bundle_cart_entity.dart';

class BundleCartEntityMapper {
  // Convierte BundleCart (Dominio) a BundleCartEntity (Infraestructura)
  BundleCartEntity mapBundleCartToEntity(BundleCart bundleCart) {
    final bundleCartEntity = BundleCartEntity(
      quantity: bundleCart.quantity,
    );

    // Asigna el enlace de producto
    bundleCartEntity.bundle.value =
        BundleEntityMapper.mapBundleToEntity(bundleCart.bundle);

    return bundleCartEntity;
  }

  // Convierte BundleCartEntity (Infraestructura) a BundleCart (Dominio)
  BundleCart mapBundleCartToDomain(BundleCartEntity entity) {
    return BundleCart(
      bundle: BundleEntityMapper.mapBundleToDomain(
          entity.bundle.value!), // Asume que el enlace ha sido cargado
      quantity: entity.quantity,
    );
  }
}
