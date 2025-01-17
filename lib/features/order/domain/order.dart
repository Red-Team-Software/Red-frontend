import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String id;
  final String orderState;
  final String orderCreatedDate;
  final double totalAmount;
  final OrderDirection orderDirection;
  final List<ProductCart> products;
  final List<BundleCart> bundles;
  final String? orderReceivedDate;
  final OrderPayment orderPayment;
  final String orderTimeCreated;
  final String? orderReport;
  final Courier? orderCourier;

  const Order({
    required this.id,
    required this.orderState,
    required this.orderCreatedDate,
    required this.totalAmount,
    required this.orderDirection,
    required this.products,
    required this.bundles,
    this.orderReceivedDate,
    required this.orderPayment,
    required this.orderTimeCreated,
    this.orderReport,
    this.orderCourier,
  });

  @override
  List<Object?> get props => [
        id,
        orderState,
        orderCreatedDate,
        totalAmount,
        orderDirection,
        products,
        bundles,
        orderReceivedDate,
        orderPayment,
        orderTimeCreated,
        orderReport,
        orderCourier,
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

class Courier {
  final String courierName;
  final String courierImage;
  final String courierPhone;
  Location? location;

  Courier({
    required this.courierName,
    required this.courierImage,
    required this.courierPhone,
    this.location,
  });

  factory Courier.fromJson(Map<String, dynamic> json) {
    return Courier(
      courierName: json['courierName'] as String,
      courierImage: json['courierImage'] as String,
      courierPhone: json['phone'] as String,
      location: null,
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: num.parse(json['latActual']).toDouble(),
      longitude: num.parse(json['longActual']).toDouble(),
    );
  }
}
