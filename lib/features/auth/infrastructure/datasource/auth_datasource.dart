import 'package:GoDeli/features/auth/application/datasources/auth_datasource.dart';
import 'package:GoDeli/features/auth/application/dto/login_dto.dart';
import 'package:GoDeli/features/auth/application/dto/register_dto.dart';
import 'package:GoDeli/features/auth/application/response/login_response.dart';
import 'package:GoDeli/features/auth/application/response/register_response.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';

class AuthDatasource implements IAuthDataSource {
  final IHttpService _httpService;

  AuthDatasource(this._httpService);

  @override
  Future<Result<LoginResponse>> login(LoginDto loginDto) async {
      final response = await _httpService.request(
        '/auth/login',
        'POST',
        (json) => LoginResponse.fromJson(json),
        body: loginDto.toJson(),
      );
      if (!response.isSuccessful()){
        return Result.makeError(Exception('Failed to login: ${response.getError()}'));
      }
      final token = response.getValue().token;
      _httpService.addHeader('Authorization', 'Bearer $token');
      return Result.success(response.getValue());
  }

  @override
  Future<Result<RegisterResponse>> register(RegisterDto registerDto) async {
    try {
      final response = await _httpService.request(
        '/auth/register',
        'POST',
        (json) => RegisterResponse.fromJson(json),
        body: registerDto.toJson(),
      );
      return Result.success(response.getValue());
    } catch (e) {
      return Result.makeError(Exception('Failed to register: ${e.toString()}'));
    }
  }
  
}
