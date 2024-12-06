

import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/user/domain/dto/update_user_dto.dart';
import 'package:GoDeli/features/user/domain/user.dart';

abstract class IUserRepository {

  Future<Result<User>> getUser();

  Future<Result<User>> updateUser(IUpdateUserDto updateUserDto);

}