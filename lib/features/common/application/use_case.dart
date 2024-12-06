import 'package:GoDeli/features/common/domain/result.dart';

abstract class IUseCase<Dto, Response> {
  Future<Result<Response>> execute(Dto dto);
}