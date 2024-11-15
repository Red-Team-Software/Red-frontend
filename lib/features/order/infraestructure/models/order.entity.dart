import 'package:GoDeli/features/bundles/infraestructure/models/bundle_entity.dart';
import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:GoDeli/features/products/infraestructure/models/product_entity.dart';

class OrderEntity {
  final String id;
  final String orderState;
  final String orderCreatedDate;
  final double totalAmount;
  final String currency;
  final OrderDirectionEntity orderDirection;
  final List<ProductCart> products;
  final List<BundleCart> bundles;
  final String? orderReceivedDate;
  final OrderPaymentEntity orderPayment;

  OrderEntity({
    required this.id,
    required this.orderState,
    required this.orderCreatedDate,
    required this.totalAmount,
    required this.currency,
    required this.orderDirection,
    required this.products,
    required this.bundles,
    this.orderReceivedDate,
    required this.orderPayment,
  });

  factory OrderEntity.fromJson(dynamic json) {
    try {
      // Verifica que el JSON sea del tipo esperado
      if (json is Map<String, dynamic>) {
        print('Parsing OrderEntity from JSON...');

        // Depuración de valores clave
        print('ID: ${json['id']}');
        print('State: ${json['orderState']}');
        print('Products: ${json['products']}');
        print('Bundles: ${json['bundles']}');

        return OrderEntity(
          id: json['id'] as String,
          orderState: json['orderState'] as String,
          orderCreatedDate: json['orderCreatedDate'] as String,
          totalAmount: (json['totalAmount'] as num).toDouble(),
          currency: json['currency'] as String,
          orderDirection: OrderDirectionEntity.fromJson(json['orderDirection']),
          products: (json['products'] as List? ?? [])
              .map((product) => ProductCart.fromJson(product))
              .toList(),
          bundles: (json['bundles'] as List? ?? [])
              .map((bundle) => BundleCart.fromJson(bundle))
              .toList(),
          orderReceivedDate: json['orderReciviedDate'] as String?,
          orderPayment: OrderPaymentEntity.fromJson(json['orderPayment']),
        );
      } else {
        print('Invalid JSON type: ${json.runtimeType}');
        throw Exception('Invalid JSON format for OrderEntity');
      }
    } catch (e, stackTrace) {
      // Log detallado del error y el stack trace para depuración
      print('Error parsing OrderEntity: $e');
      print('StackTrace: $stackTrace');
      throw Exception('Error parsing OrderEntity: $e');
    }
  }
}

class OrderDirectionEntity {
  final double latitude;
  final double longitude;

  OrderDirectionEntity({required this.latitude, required this.longitude});

  factory OrderDirectionEntity.fromJson(Map<String, dynamic> json) {
    return OrderDirectionEntity(
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['long'] as num).toDouble(),
    );
  }
}

class OrderPaymentEntity {
  final String paymentMethod;
  final String currency;
  final double amount;

  OrderPaymentEntity({
    required this.paymentMethod,
    required this.currency,
    required this.amount,
  });

  factory OrderPaymentEntity.fromJson(Map<String, dynamic> json) {
    return OrderPaymentEntity(
      paymentMethod: json['paymentMethod'] as String,
      currency: json['currency'] as String,
      amount: (json['amount'] as num).toDouble(),
    );
  }
}
