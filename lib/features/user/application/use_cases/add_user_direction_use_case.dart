import 'package:GoDeli/features/common/application/use_case.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/user/domain/dto/add_direction_dto.dart';
import 'package:GoDeli/features/user/domain/repositories/user_repository.dart';
import 'package:GoDeli/features/user/domain/user.dart';

class AddUserDirectionUseCase
    implements IUseCase<AddUserDirectionDto, User> {
  final IUserRepository _userRepository;

  AddUserDirectionUseCase(this._userRepository);

  @override
  Future<Result<User>> execute(AddUserDirectionDto dto) async {
    final resultDirectionAdded = await _userRepository.addUserDirection(dto);

    if (!resultDirectionAdded.isSuccessful()) {
      return Result.makeError(resultDirectionAdded.getError());
    }
    print('result: ${resultDirectionAdded.getValue()}');

    final res = await _userRepository.getUser();

    if (!res.isSuccessful()) {
      return Result.makeError(res.getError());
    }

    return Result.success(res.getValue());
  }
}
