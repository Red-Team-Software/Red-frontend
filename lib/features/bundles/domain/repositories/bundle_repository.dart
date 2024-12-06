import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/common/domain/result.dart';

abstract class IBundleRepository{
  
  Future<Result<Bundle>> getBundleById(String id);
  Future<Result<List<Bundle>>> getBundlesPaginated(
    {int page = 1, int perPage = 10});

  Future<Result<List<Bundle>>> searchBundles(
    {int page = 1, int perPage = 10, required String term});
}