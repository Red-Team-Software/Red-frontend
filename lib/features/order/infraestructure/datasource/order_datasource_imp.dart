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
    final res = await httpService.request(
      '/order/pay/stripe',
      'POST',
      (json) =>
          OrderMapper.mapEntityToDomain(OrderEntity.fromPaymentJson(json)),
      body: {
        "paymentId": paymentId,
        // "currency": currency,
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
      (json) {
        // Verifica si el JSON es un mapa con la clave "orders"
        if (json is Map<String, dynamic> && json['orders'] != null) {
          // Es un objeto que contiene "orders"
          return (json['orders'] as List)
              .map((order) => OrderItem.fromJson(order))
              .toList();
        } else if (json is List) {
          // Es una lista directamente
          return json.map((order) => OrderItem.fromJson(order)).toList();
        } else {
          throw Exception('Formato de respuesta desconocido');
        }
      },
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
      (json) {
        // Verifica si el JSON contiene la clave "orders"
        if (json is Map<String, dynamic> && json.containsKey('orders')) {
          return OrderMapper.mapEntityToDomain(
            OrderEntity.fromJson(json['orders']),
          );
        } else if (json is Map<String, dynamic>) {
          // El JSON está directamente en la raíz
          return OrderMapper.mapEntityToDomain(
            OrderEntity.fromJson(json),
          );
        } else {
          throw Exception('Formato de respuesta desconocido');
        }
      },
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

  @override
  Future<Location> fetchCourierPosition({required String orderId}) async {
    final res = await httpService.request(
      '/order/courier/position/$orderId',
      'GET',
      (json) => Location.fromJson(json),
    );

    if (!res.isSuccessful()) throw Exception(res.getError());
    print("Retorno del get location");
    print(res.getValue());

    return res.getValue();
  }
}
