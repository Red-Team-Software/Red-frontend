import 'package:GoDeli/features/tax-shipping/domain/tax-shipping.dart';
import 'package:GoDeli/features/tax-shipping/infraestructure/models/tax-shipping_entity.dart';

class TaxShippingMapper {
  static TaxShipping toDomain(TaxShippingEntity entity) {
    return TaxShipping(
      taxes: entity.taxes,
      shipping: entity.shipping,
    );
  }

  static TaxShippingEntity toEntity(TaxShipping domain) {
    return TaxShippingEntity(
      taxes: domain.taxes,
      shipping: domain.shipping,
    );
  }
}
