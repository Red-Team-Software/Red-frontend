import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String id;
  final String orderState;
  final String orderCreatedDate;
  final double totalAmount;
  final String currency;
  final OrderDirection orderDirection;
  final List<Product> products;
  final List<Bundle> bundles;
  final String? orderReceivedDate;
  final OrderPayment orderPayment;

  const Order({
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

  @override
  List<Object?> get props => [
        id,
        orderState,
        orderCreatedDate,
        totalAmount,
        currency,
        orderDirection,
        products,
        bundles,
        orderReceivedDate,
        orderPayment,
      ];
}

class OrderDirection {
  final double latitude;
  final double longitude;

  OrderDirection({required this.latitude, required this.longitude});
}

class OrderPayment {
  final String paymentMethod;
  final String currency;
  final double amount;

  OrderPayment({
    required this.paymentMethod,
    required this.currency,
    required this.amount,
  });
}
