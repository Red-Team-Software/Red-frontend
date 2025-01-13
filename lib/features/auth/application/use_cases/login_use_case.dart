import 'package:GoDeli/features/auth/application/dto/login_dto.dart';
import 'package:GoDeli/features/auth/application/repositories/auth_local_storage_repository.dart';
import 'package:GoDeli/features/auth/application/repositories/auth_repository.dart';
import 'package:GoDeli/features/common/application/use_case.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/user/domain/user.dart';

class LoginUseCase extends IUseCase<LoginDto, User> {
  final IAuthRepository _authRepository;  
  final IAuthLocalStorageRepository _authLocalStorageRepository;
  LoginUseCase(this._authRepository, this._authLocalStorageRepository);

  @override
  Future<Result<User>> execute(LoginDto dto) async {
    final result = await _authRepository.login(dto);
    if (result.isSuccessful()) {
      await _authLocalStorageRepository.saveToken(result.getValue().token);
      return Result.success(result.getValue().user);
    } else {
      return Result.makeError(result.getError());
    }
  }
}
