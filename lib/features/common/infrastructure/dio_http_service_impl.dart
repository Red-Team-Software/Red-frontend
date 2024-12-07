import 'package:GoDeli/config/constants/enviroments.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:dio/dio.dart';

class DioHttpServiceImpl<T> implements IHttpService {
  final Dio _dio;

  DioHttpServiceImpl()
      : _dio = Dio(
          BaseOptions(
              baseUrl: Environment.backendApi,
              headers: {'Content-Type': 'application/json'}),
        );

  @override
  void addHeader(String key, String value) {
    _dio.options.headers[key] = value;
    print(_dio.options.headers);
  }

  @override
  Future<Result<T>> request<T>(
      String url, String method, T Function(dynamic json) mapper,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.request(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(method: method),
      );
      return Result<T>.success(mapper(response.data));
    } on DioException catch (e) {
      print("a");
      print(e);
      print("b");
      print(e.response);

      return Result.makeError(e);
    }
  }

  @override
  dynamic getHeaders() {
    return _dio.options.headers;
  }

  @override
  void removeHeader(String key) {
    _dio.options.headers.remove(key);
  }

  @override
  Map<String, dynamic> getHeaderByKey(String key) {
    return _dio.options.headers[key];
  }
  //TODO: Implementar el manejo de errores
}
