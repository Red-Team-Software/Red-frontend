import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/payment-method/domain/payment-method.dart';

abstract class IPaymentMethodRepository {
  Future<Result<List<PaymentMethod>>> fetchAllPaymentMethods(
      {int page = 1, int perPage = 5});
}
