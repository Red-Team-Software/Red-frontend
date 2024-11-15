import 'package:GoDeli/features/order/domain/datasource/order_datasource.dart';
import 'package:dio/dio.dart';

import 'package:GoDeli/config/constants/enviroments.dart';

class OrderDatasourceImpl implements IOrderDatasource {
  final Dio dio = Dio(BaseOptions(baseUrl: '${Environment.backendApi}/order'));

  @override
  Future<void> processPayment({
    required double amount,
    required String currency,
    required String paymentMethod,
    required String stripePaymentMethod,
    required String address,
    required List<Map<String, dynamic>> bundles,
    required List<Map<String, dynamic>> products,
  }) async {
    print("llego 2");
    try {
      final res = await dio.post('/payment', data: {
        "amount": amount.toInt(),
        "currency": currency,
        "paymentMethod": paymentMethod,
        "stripePaymentMethod": stripePaymentMethod,
        "address": address,
        "bundles": bundles,
        "products": products,
      });
      print("rest");
      print(res);
    } catch (e) {
      if (e is DioException) {
        // Log detallado del error de Dio
        print('Error de payment: ${e.message}');
        print('Status Code: ${e.response?.statusCode}');
        print('Headers de la solicitud: ${e.requestOptions.headers}');
        print('Cuerpo de la solicitud: ${e.requestOptions.data}');
        print('Headers de la respuesta: ${e.response?.headers}');
        print('Cuerpo de la respuesta: ${e.response?.data}');
      } else {
        print('Error inesperado: $e');
      }
    }
  }
}
