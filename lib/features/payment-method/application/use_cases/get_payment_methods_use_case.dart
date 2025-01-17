
import 'package:GoDeli/features/common/application/use_case.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/payment-method/domain/payment-method.dart';
import 'package:GoDeli/features/payment-method/domain/repositories/payment-method_repository.dart';

class GetPaymentMethodsUseCase extends IUseCase<void, List<PaymentMethod>> {
  final IPaymentMethodRepository _paymentMethodRepository;

  GetPaymentMethodsUseCase(this._paymentMethodRepository);

  @override
  Future<Result<List<PaymentMethod>>> execute(void dto) async {
    return await _paymentMethodRepository.fetchAllPaymentMethods();
  }

}