import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/order/domain/order.dart';

import '../../../orders/domain/orders.dart';

abstract class IOrderDatasource {
  Future<Result<Order>> processPayment({
    required String paymentMethod,
    String? stripePaymentMethod,
    required String idUserDirection,
    required List<Map<String, dynamic>> bundles,
    required List<Map<String, dynamic>> products,
  });

  Future<List<OrderItem>> fetchAllOrders({String? state});

  Future<void> cancelOrder({required String orderId});

  Future<Order> fetchOrderById({required String orderId});

  Future<void> reportOrder(
      {required String orderId, required String description});

  Future<Location> fetchCourierPosition({required String orderId});
}
