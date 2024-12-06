import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/tax-shipping/domain/tax-shipping.dart';

abstract class ITaxShippingDatasource {
  Future<Result<TaxShipping>> calculateTaxShipping({
    required double amount,
    required String currency,
    required String address,
  });
}
