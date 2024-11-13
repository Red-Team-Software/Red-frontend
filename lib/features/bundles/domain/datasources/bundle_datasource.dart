import 'package:GoDeli/features/bundles/domain/bundle.dart';

abstract class IBundleDatasource{

  Future<Bundle> getBundleById(String id);
  Future<List<Bundle>> getBundlesPaginated(
    {int page = 1, int perPage = 10});
}