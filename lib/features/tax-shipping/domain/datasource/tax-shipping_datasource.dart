import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/tax-shipping/domain/tax-shipping.dart';

abstract class IOrderDatasource {
  Future<Result<TaxShipping>> processPayment({
    required double amount,
    required String currency,
    required String address,
  });
}
