

import 'package:GoDeli/features/auth/application/dto/update_image_dto.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/user/domain/dto/add_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/delete_user_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/update_user_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/update_user_dto.dart';
import 'package:GoDeli/features/user/domain/responses/add_user_direction_response.dart';
import 'package:GoDeli/features/user/domain/responses/update_user_direction_response.dart';
import 'package:GoDeli/features/user/domain/responses/get_user_directions_response.dart';
import 'package:GoDeli/features/user/domain/responses/update_user_response.dart';
import 'package:GoDeli/features/user/domain/user.dart';

abstract class IUserRepository {

  Future<Result<User>> getUser();

  Future<Result<UpdateUserResponse>> updateUser(UpdateUserDto updateUserDto);

  Future<Result<GetUserDirectionsResponse>> getUserDirections();

  Future<Result<AddUserDirectionResponse>> addUserDirection(AddUserDirectionDto addUserDirectionDto);

  Future<Result<bool>> deleteUserDirection(DeleteUserDirectionDto deleteUserDirectionDto);

  Future<Result<UpdateUserDirectionResponse>> updateUserDirection(UpdateUserDirectionDto updateUserDirectionDto);

  Future<Result<bool>> updateImage(UpdateImageDto updateImageDto);

}