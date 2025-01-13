import 'package:GoDeli/features/common/application/use_case.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/user/domain/repositories/user_repository.dart';
import 'package:GoDeli/features/user/domain/user.dart';

class GetUserUseCase implements IUseCase<void, User> {
  final IUserRepository _userRepository;

  GetUserUseCase(this._userRepository);

  @override
  Future<Result<User>> execute(void dto) async {
    return await _userRepository.getUser();
  }
}