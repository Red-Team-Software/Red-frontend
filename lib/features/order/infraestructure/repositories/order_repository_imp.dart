import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/order/domain/datasource/order_datasource.dart';
import 'package:GoDeli/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements IOrderRepository {
  final IOrderDatasource datasource;

  OrderRepositoryImpl({required this.datasource});

  @override
  Future<Result<void>> processPayment({
    required double amount,
    required String currency,
    required String paymentMethod,
    required String stripePaymentMethod,
    required String address,
    required List<Map<String, dynamic>> bundles,
    required List<Map<String, dynamic>> products,
  }) async {
    try {
      print("llego");
      final data = await datasource.processPayment(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
        stripePaymentMethod: stripePaymentMethod,
        address: address,
        bundles: bundles,
        products: products,
      );
      print("data");
      return Result.success("Good");
    } catch (e) {
      print("error en el rerpo");
      print(e);
      return Result.makeError(e as Exception);
    }
  }
}
