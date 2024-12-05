

import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/user/domain/datasources/user_datasource.dart';
import 'package:GoDeli/features/user/domain/dto/update_user_dto.dart';
import 'package:GoDeli/features/user/domain/user.dart';

class UserDatasourceImpl implements IUserDatasource{

  IHttpService  _httpService;

  UserDatasourceImpl(this._httpService);

  @override
  Future<Result<User>> getUser() async {
       
    final res = await _httpService.request(
      '/auth/current', 
      'GET',
      (json) => User.fromJson(json));
    
    if(!res.isSuccessful()) return Result.makeError(res.getError());
    
    return Result.success(res.getValue());
     
  }

  @override
  Future<Result<User>> updateUser(IUpdateUserDto updateUserDto) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}