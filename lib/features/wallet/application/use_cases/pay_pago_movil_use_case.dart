

import 'package:GoDeli/features/common/application/use_case.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/wallet/application/dto/add_funds_pago_movil_dto.dart';
import 'package:GoDeli/features/wallet/application/repository/wallet_repository.dart';

class PayPagoMovilUseCase implements IUseCase<AddFundsPagoMovilDto,bool> {
  final IWalletRepository _walletRepository;

  PayPagoMovilUseCase(this._walletRepository);
  @override
  Future<Result<bool>> execute(AddFundsPagoMovilDto params) async  {
    final res = await _walletRepository.addFundsPagoMovil(params);
    
    if (!res.isSuccessful()) {
      return Result.makeError(res.getError());
    }

    return Result.success(true);
      
  }
}