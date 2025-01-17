import 'package:GoDeli/features/common/application/use_case.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/wallet/application/dto/add_funds_zelle_dto.dart';
import 'package:GoDeli/features/wallet/application/repository/wallet_repository.dart';

class PayZelleUseCase implements IUseCase<AddFundsZelleDto, bool> {
  final IWalletRepository _walletRepository;

  PayZelleUseCase(this._walletRepository);

  @override
  Future<Result<bool>> execute(AddFundsZelleDto params) async {
    final res = await _walletRepository.addFundsZelle(params);

    if (!res.isSuccessful()) {
      return Result.makeError(res.getError());
    }

    return Result.success(true);
  }
}
