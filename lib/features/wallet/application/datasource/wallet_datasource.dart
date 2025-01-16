import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/wallet/application/dto/add_funds_pago_movil_dto.dart';
import 'package:GoDeli/features/wallet/application/dto/add_funds_zelle_dto.dart';

abstract class IWalletDatasource {
  Future<Result<bool>> addFundsPagoMovil(AddFundsPagoMovilDto addFundsPagoMovilDto);
  Future<Result<bool>> addFundsZelle(AddFundsZelleDto addFundsZelleDto);
}