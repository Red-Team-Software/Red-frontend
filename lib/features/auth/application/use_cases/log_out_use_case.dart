import 'package:GoDeli/features/auth/application/repositories/auth_local_storage_repository.dart';
import 'package:GoDeli/features/cart/domain/repositories/cart_local_storage_repository.dart';
import 'package:GoDeli/features/common/application/use_case.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';

class LogoutUseCase implements IUseCase<void, bool> {
  final IAuthLocalStorageRepository _authLocalStorageRepository;
  final CartLocalStorageRepository _cartLocalStorageRepository;
  final IHttpService _httpService;

  LogoutUseCase(this._httpService, this._authLocalStorageRepository,
      this._cartLocalStorageRepository);

  @override
  Future<Result<bool>> execute(void dto) async {
    try {
      _authLocalStorageRepository.deleteToken();
      _httpService.removeHeader('Authorization');
      _cartLocalStorageRepository.clearCart();
      return Result.success(true);
    } catch (e) {
      return Result.makeError(Exception(e.toString()));
    }
  }
}
