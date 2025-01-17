import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/payment-method/domain/datasource/payment-method_datasource.dart';
import 'package:GoDeli/features/payment-method/domain/payment-method.dart';
import 'package:GoDeli/features/payment-method/domain/repositories/payment-method_repository.dart';

class PaymentMethodRepositoryImpl implements IPaymentMethodRepository {
  final IPaymentMethodDatasource paymentMethodDatasource;

  PaymentMethodRepositoryImpl({required this.paymentMethodDatasource});

  @override
  Future<Result<List<PaymentMethod>>> fetchAllPaymentMethods(
      {int page = 1, int perPage = 5}) async {
    final paymentMethods = await paymentMethodDatasource.fetchAllPaymentMethods(
        page: page, perPage: perPage);

    return paymentMethods;
  }
}
