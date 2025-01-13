import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/order/domain/datasource/order_datasource.dart';
import 'package:GoDeli/features/order/domain/order.dart';
import 'package:GoDeli/features/order/infraestructure/mappers/order_mapper.dart';
import 'package:GoDeli/features/order/infraestructure/models/order.entity.dart';
import 'package:GoDeli/features/orders/domain/orders.dart';

class OrderDatasourceImpl implements IOrderDatasource {
  final IHttpService httpService;

  OrderDatasourceImpl({required this.httpService});

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
    final res = await httpService.request(
      '/order/pay/stripe',
      'POST',
      (json) =>
          OrderMapper.mapEntityToDomain(OrderEntity.fromPaymentJson(json)),
      body: {
        "paymentId": paymentId,
        "currency": currency,
        "paymentMethod": paymentMethod,
        "stripePaymentMethod": stripePaymentMethod,
        "address": address,
        "bundles": bundles,
        "products": products,
      },
    );

    if (!res.isSuccessful()) return Result.makeError(res.getError());

    return Result.success(res.getValue());
  }

  @override
  Future<List<OrderItem>> fetchAllOrders(
      {int page = 1, int perPage = 100}) async {
    final res = await httpService.request(
      '/order/user/many',
      'GET',
      (json) => (json['orders'] as List)
          .map((order) => OrderItem.fromJson(order))
          .toList(),
      queryParameters: {
        'page': page,
        'perPage': perPage,
      },
    );

    print("res de fetch all orders");
    print(res.getValue());

    if (!res.isSuccessful()) throw Exception(res.getError());

    return res.getValue();
  }

  @override
  Future<void> cancelOrder({required String orderId}) async {
    final res = await httpService.request(
        '/order/cancel/$orderId', 'GET', (json) => null);

    if (!res.isSuccessful()) throw Exception(res.getError());
  }

  @override
  Future<Order> fetchOrderById({required String orderId}) async {
    final res = await httpService.request(
      '/order/$orderId',
      'GET',
      (json) => OrderMapper.mapEntityToDomain(OrderEntity.fromJson(json)),
    );

    if (!res.isSuccessful()) throw Exception(res.getError());

    return res.getValue();
  }
}
