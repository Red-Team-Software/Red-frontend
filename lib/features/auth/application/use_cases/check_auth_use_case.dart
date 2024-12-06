import 'package:GoDeli/config/Fcm/Fcm.dart';
import 'package:GoDeli/features/auth/application/repositories/auth_local_storage_repository.dart';
import 'package:GoDeli/features/common/application/use_case.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/user/domain/user.dart';

class CheckAuthUseCase implements IUseCase<void, User> {
  final IHttpService _httpService;
  final IAuthLocalStorageRepository _authLocalStorageRepository;

  CheckAuthUseCase(this._httpService, this._authLocalStorageRepository);

  @override
  Future<Result<User>> execute(void dto) async {

    final token = await _authLocalStorageRepository.getToken();

    if (token.isEmpty) {
      return Result.makeError(Exception('No token found'));
    }

    _httpService.addHeader('Authorization', 'Bearer $token');
    
    final res = await _httpService.request('/auth/current', 'GET', (json) => User.fromJson(json));
    configureFCM(_httpService);

    if (res.isSuccessful()) {
      return Result.success(res.getValue());
    } else {
      return Result.makeError(res.getError());
    }
  }
}
