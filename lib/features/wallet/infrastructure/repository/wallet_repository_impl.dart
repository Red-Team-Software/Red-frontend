
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/wallet/application/datasource/wallet_datasource.dart';
import 'package:GoDeli/features/wallet/application/dto/add_funds_pago_movil_dto.dart';
import 'package:GoDeli/features/wallet/application/dto/add_funds_zelle_dto.dart';
import 'package:GoDeli/features/wallet/application/repository/wallet_repository.dart';

class WalletRepositoryImpl implements IWalletRepository {
  final IWalletDatasource walletDatasource;

  WalletRepositoryImpl(this.walletDatasource);

  @override
  Future<Result<bool>> addFundsPagoMovil( AddFundsPagoMovilDto addFundsPagoMovilDto) {
    return walletDatasource.addFundsPagoMovil(addFundsPagoMovilDto);
  }

  @override
  Future<Result<bool>> addFundsZelle(AddFundsZelleDto addFundsZelleDto) {
    return walletDatasource.addFundsZelle(addFundsZelleDto);
  }
}