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

      final response = await _authDataSource.login(loginDto);
      
      if (!response.isSuccessful()){
        return Result.makeError(Exception('Failed to login: ${response.getError()}'));
      }
      return Result.success(response.getValue());
  }

  @override
  Future<Result<RegisterResponse>> register(RegisterDto registerDto) async {
    try {
      final response = await _authDataSource.register(registerDto);
      return Result.success(response.getValue());
    } catch (e) {
      return Result.makeError(Exception('Failed to register: ${e.toString()}'));
    }
  }
}
