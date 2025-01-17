import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/order/domain/datasource/order_datasource.dart';
import 'package:GoDeli/features/order/domain/order.dart';
import 'package:GoDeli/features/order/domain/repositories/order_repository.dart';
import 'package:GoDeli/features/orders/domain/orders.dart';

class OrderRepositoryImpl implements IOrderRepository {
  final IOrderDatasource datasource;

  OrderRepositoryImpl({required this.datasource});

  @override
  Future<Result<Order>> processPayment({
    required String paymentMethod,
    String? stripePaymentMethod,
    required String idUserDirection,
    required List<Map<String, dynamic>> bundles,
    required List<Map<String, dynamic>> products,
  }) async {
    try {
      final order = await datasource.processPayment(
        paymentMethod: paymentMethod,
        stripePaymentMethod: stripePaymentMethod,
        idUserDirection: idUserDirection,
        bundles: bundles,
        products: products,
      );

      return order;
    } catch (e) {
      print("error en el rerpo pago");
      print("error en el rerpo");
      print(e);
      return Result.makeError(e as Exception);
    }
  }

  @override
  Future<Result<List<OrderItem>>> fetchAllOrders() async {
    try {
      final orders = await datasource.fetchAllOrders();
      return Result.success(orders);
    } catch (e) {
      print("error en el rerpo");
      print(e);
      return Result.makeError(Exception(e));
    }
  }

  @override
  Future<Result<List<OrderItem>>> fetchPastOrders() async {
    try {
      final orders = await datasource.fetchAllOrders(state: "past");
      return Result.success(orders);
    } catch (e) {
      print("error en el rerpo");
      print(e);
      return Result.makeError(Exception(e));
    }
  }

  @override
  Future<Result<List<OrderItem>>> fetchActiveOrders() async {
    try {
      final orders = await datasource.fetchAllOrders(state: "active");
      return Result.success(orders);
    } catch (e) {
      print("error en el rerpo");
      print(e);
      return Result.makeError(Exception(e));
    }
  }

  @override
  Future<Result<Order>> fetchOrderById({required String orderId}) async {
    try {
      final order = await datasource.fetchOrderById(orderId: orderId);
      return Result.success(order);
    } catch (e) {
      print("error en el rerpo");
      print(e);
      return Result.makeError(Exception(e));
    }
  }

  @override
  Future<void> cancelOrder({required String orderId}) async {
    try {
      await datasource.cancelOrder(orderId: orderId);
    } catch (e) {
      print("error en el rerpo");
      print(e);
    }
  }

  @override
  Future<void> reportOrder(
      {required String orderId, required String description}) async {
    try {
      await datasource.reportOrder(orderId: orderId, description: description);
    } catch (e) {
      print("error en el reporte de orden");
      print(e);
      throw Exception(e);
    }
  }

  @override
  Future<Result<Location>> fetchCourierPosition(
      {required String orderId}) async {
    try {
      final position = await datasource.fetchCourierPosition(orderId: orderId);
      print("position");
      return Result.success(position);
    } catch (e) {
      print("error en el rerpo");
      print(e);
      return Result.makeError(Exception(e));
    }
  }
}
