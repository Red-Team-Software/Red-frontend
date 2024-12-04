import 'package:GoDeli/features/common/domain/result.dart';

abstract class IHttpService {
  Future<Result<T>> request<T>(
      String url, String method, T Function(dynamic json) mapper,
      {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters});
  void addHeader(String key, String value);
  removeHeader(String key);
  dynamic getHeaders();
}
