import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/user/domain/datasources/user_datasource.dart';
import 'package:GoDeli/features/user/domain/dto/add_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/delete_user_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/update_user_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/update_user_dto.dart';
import 'package:GoDeli/features/user/domain/responses/add_user_direction_response.dart';
import 'package:GoDeli/features/user/domain/responses/update_user_direction_response.dart';
import 'package:GoDeli/features/user/domain/responses/get_user_directions_response.dart';
import 'package:GoDeli/features/user/domain/responses/update_user_response.dart';
import 'package:GoDeli/features/user/domain/user.dart';

class UserDatasourceImpl implements IUserDatasource {
  final IHttpService _httpService;

  UserDatasourceImpl(this._httpService);

  @override
  Future<Result<User>> getUser() async {
    final res = await _httpService.request(
        '/auth/current', 'GET', (json) => User.fromJson(json));

    if (!res.isSuccessful()) return Result.makeError(res.getError());

    return Result.success(res.getValue());
  }

  @override
  Future<Result<UpdateUserResponse>> updateUser(
      UpdateUserDto updateUserDto) async {
    final res = await _httpService.request('/user/update/profile', 'PATCH',
        (json) => UpdateUserResponse.fromJson(json),
        body: updateUserDto.toJson());

    if (!res.isSuccessful()) return Result.makeError(res.getError());

    return Result.success(res.getValue());
  }

  @override
  Future<Result<GetUserDirectionsResponse>> getUserDirections() async {
    final res = await _httpService.request('/user/address/many', 'GET',
        (json) => GetUserDirectionsResponse.fromJson(json));

    if (!res.isSuccessful()) return Result.makeError(res.getError());

    return Result.success(res.getValue());
  }

  @override
  Future<Result<AddUserDirectionResponse>> addUserDirection(
      AddUserDirectionDto addUserDirectionDto) async {
    final res = await _httpService.request('/user/add/address', 'POST',
        (json) => AddUserDirectionResponse.fromJson(json),
        body: addUserDirectionDto.toJson());

    if (!res.isSuccessful()) return Result.makeError(res.getError());

    return Result.success(res.getValue());
  }

  @override
  Future<Result<bool>> deleteUserDirection(
      DeleteUserDirectionDto deleteUserDirectionDto) async {
    final res = await _httpService.request('/user/delete/address/${deleteUserDirectionDto.id}', 'DELETE',
        (json) => true);

    if (!res.isSuccessful()) return Result.makeError(res.getError());

    return Result.success(res.getValue());
  }

  @override
  Future<Result<UpdateUserDirectionResponse>> updateUserDirection(
      UpdateUserDirectionDto updateUserDirectionDto) async {
    final res = await _httpService.request('/user/update/address', 'PATCH',
        (json) => UpdateUserDirectionResponse.fromJson(json),
        body: updateUserDirectionDto.toJson());

    if (!res.isSuccessful()) return Result.makeError(res.getError());

    return Result.success(res.getValue());
  }
}
