import 'package:GoDeli/features/auth/application/dto/login_dto.dart';
import 'package:GoDeli/features/auth/application/dto/register_dto.dart';
import 'package:GoDeli/features/auth/application/repositories/auth_local_storage_repository.dart';
import 'package:GoDeli/features/auth/application/repositories/auth_repository.dart';
import 'package:GoDeli/features/common/application/use_case.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/user/domain/user.dart';

class RegisterUseCase implements IUseCase<RegisterDto, User> {
  final IAuthRepository _authRepository;
  final IAuthLocalStorageRepository _authLocalStorageRepository;


  RegisterUseCase(this._authRepository, this._authLocalStorageRepository);

  @override
  Future<Result<User>> execute(RegisterDto dto) async {
    final registerResult = await _authRepository.register(dto);
    if (!registerResult.isSuccessful()) {
      return Result.makeError(registerResult.getError());
    }
    final loginResult = await _authRepository.login(LoginDto(dto.email, dto.password));
    if (!loginResult.isSuccessful()) {
      return Result.makeError(loginResult.getError());
    }
    await _authLocalStorageRepository.saveToken(loginResult.getValue().token);
    return Result.success(loginResult.getValue().user);
  }
}
