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
      orderTimeCreated: entity.orderTimeCreated,
      totalAmount: entity.totalAmount,
      orderDirection: OrderDirection(
        latitude: entity.orderDirection.latitude,
        longitude: entity.orderDirection.longitude,
      ),
      products: entity.products,
      bundles: entity.bundles,
      orderReceivedDate: entity.orderReceivedDate,
      orderPayment: OrderPayment(
        paymentMethod: entity.orderPayment.paymentMethod,
        currency: entity.orderPayment.currency,
        amount: entity.orderPayment.amount,
      ),
    );
  }

  static Order mapOneEntityToDomain(OrderEntity entity) {
    return Order(
      id: entity.id,
      orderState: entity.orderState,
      orderCreatedDate: entity.orderCreatedDate,
      orderTimeCreated: entity.orderTimeCreated,
      totalAmount: entity.totalAmount,
      orderDirection: OrderDirection(
        latitude: entity.orderDirection.latitude,
        longitude: entity.orderDirection.longitude,
      ),
      products: entity.products,
      bundles: entity.bundles,
      orderReceivedDate: entity.orderReceivedDate,
      orderPayment: OrderPayment(
        paymentMethod: entity.orderPayment.paymentMethod,
        currency: entity.orderPayment.currency,
        amount: entity.orderPayment.amount,
      ),
    );
  }
}
