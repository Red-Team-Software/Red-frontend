import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/order/domain/order.dart';
import 'package:GoDeli/features/orders/domain/orders.dart';

abstract class IOrderRepository {
  Future<Result<Order>> processPayment({
    required String paymentId,
    required String currency,
    required String paymentMethod,
    required String stripePaymentMethod,
    required String idUserDirection,
    required List<Map<String, dynamic>> bundles,
    required List<Map<String, dynamic>> products,
  });

  Future<Result<List<OrderItem>>> fetchAllOrders();

  Future<Result<Order>> fetchOrderById({required String orderId});

  Future<void> cancelOrder({required String orderId});

  Future<void> reportOrder(
      {required String orderId, required String description});

  Future<Result<List<OrderItem>>> fetchPastOrders();

  Future<Result<List<OrderItem>>> fetchActiveOrders();

  Future<Result<Location>> fetchCourierPosition({required String orderId});
}
