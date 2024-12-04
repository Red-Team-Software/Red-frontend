

import 'package:GoDeli/features/auth/application/dto/login_dto.dart';
import 'package:GoDeli/features/auth/application/dto/register_dto.dart';
import 'package:GoDeli/features/auth/application/response/login_response.dart';
import 'package:GoDeli/features/auth/application/response/register_response.dart';
import 'package:GoDeli/features/common/domain/result.dart';




abstract class IAuthRepository {
  Future<Result<LoginResponse>> login(LoginDto loginDto);
  Future<Result<RegisterResponse>> register(RegisterDto registerDto);
  // Future<Result<User>> getCurrentUser();
}