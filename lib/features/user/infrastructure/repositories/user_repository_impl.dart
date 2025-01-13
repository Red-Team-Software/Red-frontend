

import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/user/domain/datasources/user_datasource.dart';
import 'package:GoDeli/features/user/domain/dto/add_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/delete_update_user_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/update_user_dto.dart';
import 'package:GoDeli/features/user/domain/repositories/user_repository.dart';
import 'package:GoDeli/features/user/domain/responses/add_user_direction_response.dart';
import 'package:GoDeli/features/user/domain/responses/delete_update_user_direction_response.dart';
import 'package:GoDeli/features/user/domain/responses/get_user_directions_response.dart';
import 'package:GoDeli/features/user/domain/responses/update_user_response.dart';
import 'package:GoDeli/features/user/domain/user.dart';

class UserRepositoryImpl implements IUserRepository{
  
  final IUserDatasource _userDatasource;
  
  UserRepositoryImpl(this._userDatasource);

  @override
  Future<Result<User>> getUser() {
    return _userDatasource.getUser();
  }

  @override
  Future<Result<UpdateUserResponse>> updateUser(UpdateUserDto updateUserDto) {
    return _userDatasource.updateUser(updateUserDto);
  }

  @override
  Future<Result<GetUserDirectionsResponse>> getUserDirections() {
    return _userDatasource.getUserDirections();
  }

  @override
  Future<Result<AddUserDirectionResponse>> addUserDirection(AddUserDirectionListDto updateUserDto) {
    return _userDatasource.addUserDirection(updateUserDto);
  }

  @override
  Future<Result<DeleteUpdateUserDirectionResponse>> deleteUserDirection(DeleteUpdateUserDirectionListDto deleteUserDirectionDto) {
    return _userDatasource.deleteUserDirection(deleteUserDirectionDto);
  }

  @override
  Future<Result<DeleteUpdateUserDirectionResponse>> updateUserDirection(DeleteUpdateUserDirectionListDto updateUserDirectionDto) {
    return _userDatasource.updateUserDirection(updateUserDirectionDto);
  }

  

}