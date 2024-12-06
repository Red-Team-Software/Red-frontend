import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/tax-shipping/domain/tax-shipping.dart';
import 'package:GoDeli/features/tax-shipping/domain/repositories/tax-shipping_repository.dart';
import 'package:GoDeli/features/tax-shipping/domain/datasource/tax-shipping_datasource.dart';

class TaxShippingRepositoryImpl implements ITaxShippinRepository {
  final ITaxShippingDatasource datasource;

  TaxShippingRepositoryImpl({required this.datasource});

  @override
  Future<Result<TaxShipping>> calculateTaxShipping({
    required double amount,
    required String currency,
    required String address,
  }) async {
    try {
      final taxShipping = await datasource.calculateTaxShipping(
        amount: amount,
        currency: currency,
        address: address,
      );

      return taxShipping;
    } catch (e) {
      print("Error in TaxShippingRepositoryImpl");
      print(e);
      return Result.makeError(e as Exception);
    }
  }
}
