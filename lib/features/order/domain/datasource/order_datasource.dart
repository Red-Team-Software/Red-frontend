import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/order/domain/order.dart';

abstract class IOrderDatasource {
  Future<Result<Order>> processPayment({
    required double amount,
    required String currency,
    required String paymentMethod,
    required String stripePaymentMethod,
    required String address,
    required List<Map<String, dynamic>> bundles,
    required List<Map<String, dynamic>> products,
  });
}
