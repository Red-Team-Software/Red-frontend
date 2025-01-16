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
    required String idUserDirection,
    required List<Map<String, dynamic>> bundles,
    required List<Map<String, dynamic>> products,
  }) async {
    print("req");
    print(paymentId);
    print(currency);
    print(paymentMethod);
    print(stripePaymentMethod);
    print(idUserDirection);
    print(bundles);
    print(products);

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
        "idUserDirection": idUserDirection,
        "bundles": bundles,
        "products": products,
      },
    );

    if (!res.isSuccessful()) return Result.makeError(res.getError());

    return Result.success(res.getValue());
  }

  @override
  Future<List<OrderItem>> fetchAllOrders({String? state}) async {
    final queryParams = {
      if (state != null) 'state': state,
    };

    final res = await httpService.request(
      '/order/user/many',
      'GET',
      (json) => (json['orders'] as List)
          .map((order) => OrderItem.fromJson(order))
          .toList(),
      queryParameters: queryParams,
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

  @override
  Future<void> reportOrder(
      {required String orderId, required String description}) async {
    final res = await httpService.request(
      '/order/report',
      'POST',
      (json) => true,
      body: {
        "orderId": orderId,
        "description": description,
      },
    );
    if (!res.isSuccessful()) throw Exception(res.getError());
  }
}
