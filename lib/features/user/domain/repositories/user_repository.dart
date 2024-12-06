

import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/user/domain/dto/add_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/delete_update_user_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/update_user_dto.dart';
import 'package:GoDeli/features/user/domain/responses/add_user_direction_response.dart';
import 'package:GoDeli/features/user/domain/responses/delete_update_user_direction_response.dart';
import 'package:GoDeli/features/user/domain/responses/get_user_directions_response.dart';
import 'package:GoDeli/features/user/domain/responses/update_user_response.dart';
import 'package:GoDeli/features/user/domain/user.dart';

abstract class IUserRepository {

  Future<Result<User>> getUser();

  Future<Result<UpdateUserResponse>> updateUser(UpdateUserDto updateUserDto);

  Future<Result<GetUserDirectionsResponse>> getUserDirections();

  Future<Result<AddUserDirectionResponse>> addUserDirection(AddUserDirectionListDto addUserDirectionDto);

  Future<Result<DeleteUpdateUserDirectionResponse>> deleteUserDirection(DeleteUpdateUserDirectionListDto deleteUserDirectionDto);

  Future<Result<DeleteUpdateUserDirectionResponse>> updateUserDirection(DeleteUpdateUserDirectionListDto updateUserDirectionDto);


}