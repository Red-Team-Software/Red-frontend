import 'package:dio/dio.dart';
import 'package:GoDeli/config/constants/enviroments.dart';

class NotificationDatasource {
  final Dio dio =
      Dio(BaseOptions(baseUrl: '${Environment.backendApi}/notification'));

  Future<void> saveToken(String token) async {
    try {
      final response = await dio.post('/savetoken', data: {'token': token});
      print('Token guardado exitosamente: ${response.statusCode}');
    } on DioException catch (e) {
      print('Error al guardar el token: ${e.message}');
      print('URL: ${e.requestOptions.uri}');
      print('Headers: ${e.requestOptions.headers}');
      print('Method: ${e.requestOptions.method}');
      print('Status code: ${e.response?.statusCode}');
      print('Response data: ${e.response?.data}');
      print('Stack trace: $e');
    } catch (e) {
      print('Error inesperado: $e');
    }
  }
}
