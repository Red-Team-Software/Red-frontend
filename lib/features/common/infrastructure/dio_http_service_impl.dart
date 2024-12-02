
import 'package:GoDeli/config/constants/enviroments.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:dio/dio.dart';

class DioHttpServiceImpl<T> implements IHttpService {

  final Dio _dio;

  DioHttpServiceImpl() : _dio = Dio(
    BaseOptions(
      baseUrl: Environment.backendApi,
      headers: {'Content-Type': 'application/json'}
    ),
  );
  
  @override
  void addHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }
  
  @override
  Future<Result<T>> request<T>(
    String url,
    String method,
    T Function(Map<String, dynamic> json) mapper,
    {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters}
  ) async {
    try {
      final response = await _dio.request(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(method: method),
      );

      return Result<T>.success(mapper(response.data));
    } on  DioException catch (e) {
      return Result.makeError(e);
    }
  }


  //TODO: Implementar el manejo de errores

}