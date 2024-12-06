import 'package:GoDeli/features/common/application/use_case.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/user/domain/repositories/user_repository.dart';
import 'package:GoDeli/features/user/domain/user_direction.dart';

class GetUserDirectionsUseCase implements IUseCase<void, List<UserDirection>> {
  final IUserRepository _userRepository;

  GetUserDirectionsUseCase(this._userRepository);
  
  @override
  Future<Result<List<UserDirection>>> execute(void request) async {
    final res = await _userRepository.getUserDirections();

    if (!res.isSuccessful()) {
      throw Exception(res.getError());
    }

    return Result.success(res.getValue().directions);
  }
}
