import 'package:GoDeli/features/bundles/infraestructure/mappers/bundle_entity_mapper.dart';
import 'package:GoDeli/features/bundles/infraestructure/mappers/bundle_mapper.dart';
import 'package:GoDeli/features/order/domain/order.dart';
import 'package:GoDeli/features/order/infraestructure/models/order.entity.dart';
import 'package:GoDeli/features/products/infraestructure/mappers/product_entity_mapper.dart';
import 'package:GoDeli/features/products/infraestructure/mappers/product_mapper.dart';

class OrderMapper {
  static Order mapEntityToDomain(OrderEntity entity) {
    return Order(
      id: entity.id,
      orderState: entity.orderState,
      orderCreatedDate: entity.orderCreatedDate,
      totalAmount: entity.totalAmount,
      currency: entity.currency,
      orderDirection: OrderDirection(
        latitude: entity.orderDirection.latitude,
        longitude: entity.orderDirection.longitude,
      ),
      products: entity.products
          .map((productEntity) =>
              ProductEntityMapper.mapProductToDomain(productEntity))
          .toList(),
      bundles: entity.bundles
          .map((bundleEntity) =>
              BundleEntityMapper.mapBundleToDomain(bundleEntity))
          .toList(),
      orderReceivedDate: entity.orderReceivedDate,
      orderPayment: OrderPayment(
        paymentMethod: entity.orderPayment.paymentMethod,
        currency: entity.orderPayment.currency,
        amount: entity.orderPayment.amount,
      ),
    );
  }
}
