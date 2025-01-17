import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/tax-shipping/domain/datasource/tax-shipping_datasource.dart';
import 'package:GoDeli/features/tax-shipping/domain/tax-shipping.dart';
import 'package:GoDeli/features/tax-shipping/infraestructure/mappers/tax-shipping_mapper.dart';
import 'package:GoDeli/features/tax-shipping/infraestructure/models/tax-shipping_entity.dart';

class TaxShippingDatasourceImpl implements ITaxShippingDatasource {
  final IHttpService httpService;

  TaxShippingDatasourceImpl({required this.httpService});

  @override
  Future<Result<TaxShipping>> calculateTaxShipping({
    required double amount,
    required String currency,
    required String address,
  }) async {
    print('Calculating tax and shipping fee= $amount, $currency, $address');
    final res = await httpService.request(
      '/order/tax-shipping-fee',
      'POST',
      (json) => TaxShippingMapper.toDomain(TaxShippingEntity.fromJson(json)),
      body: {
        "amount": amount,
        "currency": currency,
        "address": address,
      },
    );

    if (!res.isSuccessful()) return Result.makeError(res.getError());

    return Result.success(res.getValue());
  }
}
