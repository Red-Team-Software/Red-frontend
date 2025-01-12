import 'package:GoDeli/features/auth/application/datasources/auth_datasource.dart';
import 'package:GoDeli/features/auth/application/dto/login_dto.dart';
import 'package:GoDeli/features/auth/application/dto/register_dto.dart';
import 'package:GoDeli/features/auth/application/repositories/auth_repository.dart';
import 'package:GoDeli/features/auth/application/response/login_response.dart';
import 'package:GoDeli/features/auth/application/response/register_response.dart';
import 'package:GoDeli/features/common/domain/result.dart';

class AuthRepository implements IAuthRepository {
  final IAuthDataSource _authDataSource;

  AuthRepository(this._authDataSource);

  @override
  Future<Result<LoginResponse>> login(LoginDto loginDto) async {
    return await _authDataSource.login(loginDto);
  }

  @override
  Future<Result<RegisterResponse>> register(RegisterDto registerDto) async {
    return await _authDataSource.register(registerDto);
  }
}
