import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/order/domain/datasource/order_datasource.dart';
import 'package:GoDeli/features/order/domain/order.dart';
import 'package:GoDeli/features/order/domain/repositories/order_repository.dart';
import 'package:GoDeli/features/order/infraestructure/mappers/order_mapper.dart';
import 'package:GoDeli/features/order/infraestructure/models/order.entity.dart';

class OrderRepositoryImpl implements IOrderRepository {
  final IOrderDatasource datasource;

  OrderRepositoryImpl({required this.datasource});

  @override
  Future<Result<Order>> processPayment({
    required String paymentId,
    required String currency,
    required String paymentMethod,
    required String stripePaymentMethod,
    required String address,
    required List<Map<String, dynamic>> bundles,
    required List<Map<String, dynamic>> products,
  }) async {
    try {
      final order = await datasource.processPayment(
        paymentId: paymentId,
        currency: currency,
        paymentMethod: paymentMethod,
        stripePaymentMethod: stripePaymentMethod,
        address: address,
        bundles: bundles,
        products: products,
      );

      return order;
    } catch (e) {
      print("error en el rerpo");
      print(e);
      return Result.makeError(e as Exception);
    }
  }
}
