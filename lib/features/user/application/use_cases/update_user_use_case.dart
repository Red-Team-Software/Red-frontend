import 'package:GoDeli/features/common/application/use_case.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/user/domain/dto/update_user_dto.dart';
import 'package:GoDeli/features/user/domain/repositories/user_repository.dart';
import 'package:GoDeli/features/user/domain/user.dart';

class UpdateUserUseCase implements IUseCase<UpdateUserDto, User> {
  final IUserRepository _userRepository;

  UpdateUserUseCase(this._userRepository);

  @override
  Future<Result<User>> execute(UpdateUserDto dto) async {
    final updateResult = await _userRepository.updateUser(dto);

    if (!updateResult.isSuccessful()) {
      'Failed to update user: ${updateResult.getError()}';
      return Result.makeError(updateResult.getError());
    }

    final getUserResult = await _userRepository.getUser();

    if (!getUserResult.isSuccessful()) {
      'Failed to get user: ${getUserResult.getError()}';
      return Result.makeError(getUserResult.getError());
    }

    return Result.success(getUserResult.getValue());
  }
}
