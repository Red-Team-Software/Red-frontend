import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/wallet/application/datasource/wallet_datasource.dart';
import 'package:GoDeli/features/wallet/application/dto/add_funds_pago_movil_dto.dart';
import 'package:GoDeli/features/wallet/application/dto/add_funds_zelle_dto.dart';

class WalletDatasourceImpl implements IWalletDatasource {

  final IHttpService _httpService;

  WalletDatasourceImpl(this._httpService);


  @override
  Future<Result<void>> addFundsPagoMovil(AddFundsPagoMovilDto addFundsPagoMovilDto) async {
    final res = await _httpService.request(
      '/pay/pago-movil',
       'POST', 
       (json) => null,
       body: addFundsPagoMovilDto.toJson()
    );
    if (!res.isSuccessful()) return Result.makeError(res.getError());
    print('En pago movil: ${res.getValue()}');

    return Result.success(null);
  }

  @override
  Future<Result<void>> addFundsZelle(AddFundsZelleDto addFundsZelleDto) async  {
    final res = await _httpService.request(
      '/pay/zelle',
       'POST', 
       (json) => null,
       body: addFundsZelleDto.toJson()
    );
    if (!res.isSuccessful()) return Result.makeError(res.getError());
    print('En zelle: ${res.getValue()}');

    return Result.success(null);

  }
}
