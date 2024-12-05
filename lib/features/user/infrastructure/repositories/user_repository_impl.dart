

import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/user/domain/datasources/user_datasource.dart';
import 'package:GoDeli/features/user/domain/dto/update_user_dto.dart';
import 'package:GoDeli/features/user/domain/repositories/user_repository.dart';
import 'package:GoDeli/features/user/domain/user.dart';

class UserRepositoryImpl implements IUserRepository{
  
  final IUserDatasource _userDatasource;
  
  UserRepositoryImpl(this._userDatasource);

  @override
  Future<Result<User>> getUser() {
    return _userDatasource.getUser();
  }

  @override
  Future<Result<User>> updateUser(IUpdateUserDto updateUserDto) {
    return _userDatasource.updateUser(updateUserDto);
  }
    
}