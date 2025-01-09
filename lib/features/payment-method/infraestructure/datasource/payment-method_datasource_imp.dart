import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/payment-method/domain/datasource/payment-method_datasource.dart';
import 'package:GoDeli/features/payment-method/domain/payment-method.dart';
import 'package:GoDeli/features/common/domain/result.dart';

class PaymentMethodDatasourceImpl implements IPaymentMethodDatasource {
  final IHttpService _httpService;

  PaymentMethodDatasourceImpl(this._httpService);

  @override
  Future<Result<List<PaymentMethod>>> fetchAllPaymentMethods(
      {int page = 1, int perPage = 5}) async {
    final res = await _httpService.request(
        '/payment-method/all',
        'GET',
        (json) =>
            (json as List).map((item) => PaymentMethod.fromJson(item)).toList(),
        queryParameters: {
          'page': page,
          'perPage': perPage,
        });

    if (res.isSuccessful()) {
      return Result<List<PaymentMethod>>.success(res.getValue());
    } else {
      return Result<List<PaymentMethod>>.makeError(
          Exception('Failed to fetch payment methods'));
    }
  }
}
