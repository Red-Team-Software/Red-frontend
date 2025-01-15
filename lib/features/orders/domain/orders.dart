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
  final String summaryOrder;
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
    required this.summaryOrder,
    this.orderReceivedDate,
    required this.orderPayment,
    required this.orderDirection,
    required this.products,
    required this.bundles,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    try {
      return OrderItem(
        orderId: json['id'] as String,
        orderState: json['last_state']['state'] as String,
        orderCreatedDate: json['last_state']['date'] as String,
        totalAmount: (json['totalAmount'] as num).toDouble(),
        summaryOrder: json['summary_order'] as String,
        orderReceivedDate: null,
        orderPayment: OrderPayment(
          paymentMethod: "", // Update as per your requirement
          currency: "", // Update as per your requirement
          amount: 0.0, // Update as per your requirement
        ),
        orderDirection: OrderDirection(
          latitude: num.parse(json['orderDirection']['lat']) as double,
          longitude: num.parse(json['orderDirection']['long']) as double,
        ),
        products: [], // Update as per your requirement
        bundles: [], // Update as per your requirement
      );
    } catch (e, stackTrace) {
      print('Error parsing OrderItem: $e');
      print('StackTrace: $stackTrace');
      rethrow;
    }
  }
}
