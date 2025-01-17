import 'package:GoDeli/features/auth/application/dto/update_image_dto.dart';
import 'package:GoDeli/features/common/application/use_case.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/user/domain/repositories/user_repository.dart';

class UpdateImageUseCase implements IUseCase<UpdateImageDto, bool> {

  final IUserRepository userRepository;

  UpdateImageUseCase(this.userRepository);

  @override
  Future<Result<bool>> execute(UpdateImageDto dto) async {
    final res = await userRepository.updateImage(dto);

    if (res.isSuccessful()) {
      return Result.success(true);
    } else {
      return Result.makeError(res.getError());
    }
  }

}
