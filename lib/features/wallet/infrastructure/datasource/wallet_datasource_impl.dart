import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/wallet/application/datasource/wallet_datasource.dart';
import 'package:GoDeli/features/wallet/application/dto/add_funds_pago_movil_dto.dart';
import 'package:GoDeli/features/wallet/application/dto/add_funds_zelle_dto.dart';

class WalletDatasourceImpl implements IWalletDatasource {

  final IHttpService _httpService;

  WalletDatasourceImpl(this._httpService);


  @override
  Future<Result<bool>> addFundsPagoMovil(AddFundsPagoMovilDto addFundsPagoMovilDto) async {
    final res = await _httpService.request(
      '/payment/method/recharge/pago-movil',
       'POST', 
       (json) => true,
       body: addFundsPagoMovilDto.toJson()
    );
    if (!res.isSuccessful()) {
      return Result.makeError(res.getError());
    }
    return Result.success(true);
  }

  @override
  Future<Result<bool>> addFundsZelle(AddFundsZelleDto addFundsZelleDto) async  {
    print('El json es : ' + addFundsZelleDto.toJson().toString());

    final res = await _httpService.request(
      '/payment/method/recharge/zelle',
       'POST', 
       (json) => true,
       body: addFundsZelleDto.toJson()
    );
    if (!res.isSuccessful()){
      return Result.makeError(res.getError());
    } 
    print('En zelle: ${res.getValue()}');

    return Result.success(false);

  }
}
