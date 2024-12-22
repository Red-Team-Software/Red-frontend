import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';

class OrderEntity {
  final String id;
  final String orderState;
  final String orderCreatedDate;
  final String orderTimeCreated;

  final double totalAmount;
  final OrderDirectionEntity orderDirection;
  final List<ProductCart> products;
  final List<BundleCart> bundles;
  final String? orderReceivedDate;
  final OrderPaymentEntity orderPayment;

  OrderEntity({
    required this.id,
    required this.orderState,
    required this.orderCreatedDate,
    required this.orderTimeCreated,
    required this.totalAmount,
    required this.orderDirection,
    required this.products,
    required this.bundles,
    this.orderReceivedDate,
    required this.orderPayment,
  });

  factory OrderEntity.fromPaymentJson(dynamic json) {
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
          orderTimeCreated: json['orderTimeCreated'] as String,
          orderDirection: OrderDirectionEntity.fromJson(json['orderDirection']),
          products: (json['products'] as List? ?? [])
              .map((product) => ProductCart.fromJson(product))
              .toList(),
          bundles: (json['bundles'] as List? ?? [])
              .map((bundle) => BundleCart.fromJson(bundle))
              .toList(),
          orderReceivedDate: json['orderReceivedDate'] as String? ?? '',
          orderPayment:
              OrderPaymentEntity.fromPaymentJson(json['orderPayment']),
        );
      } else {
        print('Invalid JSON type: ${json.runtimeType}');
        throw Exception('Invalid JSON format for OrderEntity');
      }
    } catch (e, stackTrace) {
      // Log detallado del error y el stack trace para depuración
      print('Error parsing OrderEntity: $e');
      print('StackTrace: $stackTrace');
      throw Exception(
          'Error parsing OrderEntity at ${stackTrace.toString().split('\n')[0]}: $e');
    }
  }

  factory OrderEntity.fromJson(dynamic json) {
    try {
      // Verifica que el JSON sea del tipo esperado
      if (json is Map<String, dynamic> && json.containsKey('orders')) {
        final orderJson = json['orders'];
        print('Parsing OrderEntity from JSON...');
        print('JSON: $orderJson');
        // Depuración de valores clave
        print('ID: ${orderJson['orderId']}');
        print('State: ${orderJson['orderState']}');
        print('Created Date: ${orderJson['orderCreatedDate']}');
        print('Time Created: ${orderJson['orderTimeCreated']}');
        print('Total Amount: ${orderJson['totalAmount']}');
        print('Direction: ${orderJson['orderDirection']}');
        print('Products: ${orderJson['products']}');
        print('Bundles: ${orderJson['bundles']}');
        print('Received Date: ${orderJson['orderReceivedDate']}');
        print('Payment: ${orderJson['orderPayment']}');

        return OrderEntity(
          id: orderJson['orderId'] as String? ?? '',
          orderState: orderJson['orderState'] as String? ?? '',
          orderCreatedDate: orderJson['orderCreatedDate'] as String? ?? '',
          orderTimeCreated: orderJson['orderTimeCreated'] as String? ?? '',
          totalAmount: (orderJson['totalAmount'] as num).toDouble(),
          orderDirection:
              OrderDirectionEntity.fromJson(orderJson['orderDirection']),
          products: (orderJson['products'] as List? ?? [])
              .map((product) => ProductCart.fromJson(product))
              .toList(),
          bundles: (orderJson['bundles'] as List? ?? [])
              .map((bundle) => BundleCart.fromJson(bundle))
              .toList(),
          orderReceivedDate: orderJson['orderReceivedDate'] as String? ?? '',
          orderPayment: OrderPaymentEntity.fromJson(orderJson['orderPayment']),
        );
      } else {
        print('Invalid JSON type or missing "orders" key: ${json.runtimeType}');
        throw Exception('Invalid JSON format for OrderEntity');
      }
    } catch (e, stackTrace) {
      // Log detallado del error y el stack trace para depuración
      print('Error parsing OrderEntity: $e');
      print('StackTrace: $stackTrace');
      throw Exception(
          'Error parsing OrderEntity at ${stackTrace.toString().split('\n')[0]}: $e');
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

  factory OrderPaymentEntity.fromPaymentJson(Map<String, dynamic> json) {
    return OrderPaymentEntity(
      paymentMethod: json['paymentMethod'] as String,
      currency: json['currency'] as String,
      amount: (json['amount'] as num).toDouble(),
    );
  }

  factory OrderPaymentEntity.fromJson(Map<String, dynamic> json) {
    return OrderPaymentEntity(
      paymentMethod: json['payementMethod'] as String,
      currency: json['paymentCurrency'] as String,
      amount: (json['paymetAmount'] as num).toDouble(),
    );
  }
}
