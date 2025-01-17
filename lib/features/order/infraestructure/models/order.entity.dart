import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:GoDeli/features/order/domain/order.dart';

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
  final Courier? orderCourier;

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
    this.orderCourier,
  });

  factory OrderEntity.fromPaymentJson(dynamic json) {
    try {
      // Verifica que el JSON sea del tipo esperado
      if (json is Map<String, dynamic>) {
        print('Parsing OrderEntity from JSON...');
        print("Fallo el 1");

        // Depuración de valores clave
        print('ID: ${json['id']}');
        print('State: ${json['orderState']}');
        print('Products: ${json['products']}');
        print('Bundles: ${json['bundles']}');

        return OrderEntity(
          id: json['id'] as String,
          orderState: json['orderState'][0]["state"] as String,
          orderCreatedDate: '',
          totalAmount: 0,
          orderTimeCreated: json['orderTimeCreated'] as String,
          orderDirection: OrderDirectionEntity.fromDummy(),
          products: [],
          bundles: [],
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

  factory OrderEntity.fromJson(dynamic orderJson) {
    try {
      // Verifica que el JSON sea del tipo esperado
      
        return OrderEntity(
          id: orderJson['orderId'] as String? ?? '',
          orderState: orderJson['orderState'][0]['state'] as String? ?? '',
          orderCreatedDate: orderJson['orderState'][0]['date'] as String? ?? '',
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
          orderCourier: orderJson['orderCourier'] != null
              ? Courier.fromJson(orderJson['orderCourier'])
              : null,
        );

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
      latitude: _parseToDouble(json['lat']),
      longitude: _parseToDouble(json['long']),
    );
  }

  factory OrderDirectionEntity.fromDummy() {
    return OrderDirectionEntity(
      latitude: 10.472567,
      longitude: -66.765795,
    );
  }
}

double _parseToDouble(dynamic value) {
  if (value is double) {
    return value; // El valor ya es un double
  } else if (value is int) {
    return value.toDouble(); // Convertir int a double
  } else if (value is String) {
    return double.tryParse(value) ?? 0.0; // Intentar convertir cadena a double
  }
  throw ArgumentError('El valor no se puede convertir a double: $value');
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
      paymentMethod: json['paymentMethod'] as String,
      currency: json['paymentCurrency'] as String,
      amount: (json['paymetAmount'] is String
              ? num.parse(json['paymetAmount']).toDouble()
              : json['paymetAmount'] as num)
          .toDouble(),
    );
  }
}
