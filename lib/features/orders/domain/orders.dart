import 'package:GoDeli/features/order/domain/order.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:GoDeli/features/cart/domain/bundle_cart.dart';

class Orders {
  final List<OrderItem> orders;

  Orders({required this.orders});

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      orders: (json['orders'] as List)
          .map((order) => OrderItem.fromJson(order))
          .toList(),
    );
  }
}

class OrderItem {
  final String orderId;
  final String orderState;
  final String orderCreatedDate;
  final double totalAmount;
  final String? orderReceivedDate;
  final OrderPayment orderPayment;
  final OrderDirection orderDirection;
  final List<ProductCart> products;
  final List<BundleCart> bundles;

  OrderItem({
    required this.orderId,
    required this.orderState,
    required this.orderCreatedDate,
    required this.totalAmount,
    this.orderReceivedDate,
    required this.orderPayment,
    required this.orderDirection,
    required this.products,
    required this.bundles,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    try {
      return OrderItem(
        orderId: json['orderId'] as String,
        orderState: json['orderState'] as String,
        orderCreatedDate: json['orderCreatedDate'] as String,
        totalAmount: (json['totalAmount'] as num).toDouble(),
        orderReceivedDate: "",
        orderPayment: OrderPayment(
          paymentMethod: json['orderPayment']['payementMethod'] as String,
          currency: json['orderPayment']['paymentCurrency'] as String,
          amount: (json['orderPayment']['paymetAmount'] as num).toDouble(),
        ),
        orderDirection: OrderDirection(
          latitude: num.parse(json['orderDirection']['lat']) as double,
          longitude: num.parse(json['orderDirection']['long']) as double,
        ),
        products: (json['products'] as List)
            .map((product) => ProductCart.fromJson(product))
            .toList(),
        bundles: (json['bundles'] as List)
            .map((bundle) => BundleCart.fromJson(bundle))
            .toList(),
      );
    } catch (e, stackTrace) {
      print('Error parsing OrderItem: $e');
      print('StackTrace: $stackTrace');
      rethrow;
    }
  }
}
