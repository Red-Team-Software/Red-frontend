

import 'package:GoDeli/features/common/application/use_case.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/user/domain/dto/delete_user_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/update_user_direction_dto.dart';
import 'package:GoDeli/features/user/domain/repositories/user_repository.dart';
import 'package:GoDeli/features/user/domain/user.dart';

class DeleteUserDirectionUseCase implements IUseCase<DeleteUserDirectionDto, User> {
  
  final IUserRepository _userRepository;

  DeleteUserDirectionUseCase(this._userRepository);
  
  @override
  Future<Result<User>> execute(DeleteUserDirectionDto dto) async {
    final resultDirectionAdded = await _userRepository.deleteUserDirection(dto);

    if( !resultDirectionAdded.isSuccessful() ) {
      return Result.makeError(resultDirectionAdded.getError());
    }
    print('result: ${resultDirectionAdded.getValue()}');

    final res = await _userRepository.getUser();

    if( !res.isSuccessful() ) {
      return Result.makeError(res.getError());
    }

    return Result.success(res.getValue());

    
  }

}