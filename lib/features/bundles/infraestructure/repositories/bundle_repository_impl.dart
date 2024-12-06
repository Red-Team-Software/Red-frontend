import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/bundles/domain/datasources/bundle_datasource.dart';
import 'package:GoDeli/features/bundles/domain/repositories/bundle_repository.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:dio/dio.dart';

class BundleRepositoryImpl implements IBundleRepository {
  final IBundleDatasource bundleDatasource;

  BundleRepositoryImpl({required this.bundleDatasource});

  @override
  Future<Result<Bundle>> getBundleById(String id) async {
    try {
      final bundle = await bundleDatasource.getBundleById(id);
      return Result<Bundle>.success(bundle);
    } catch (error, _) {
      return Result<Bundle>.makeError(error as Exception);
    }
  }

  @override
  Future<Result<List<Bundle>>> getBundlesPaginated(
      {int page = 1, int perPage = 10}) async {
    try {
      final bundles = await bundleDatasource.getBundlesPaginated(
          page: page, perPage: perPage);
      return Result<List<Bundle>>.success(bundles);
    } catch (error) {
      return Result<List<Bundle>>.makeError(Exception(error.toString()));
    }
  }
  
  @override
  Future<Result<List<Bundle>>> searchBundles({int page = 1, int perPage = 10, required String term}) async {
    try {
      final bundles = await bundleDatasource.searchBundles(page: page, perPage: perPage, term: term);
      return Result<List<Bundle>>.success(bundles);
    } on DioException catch (dioError) {
      return Result<List<Bundle>>.makeError(Exception('Dio error: ${dioError.toString()}'));
    } catch (error, _) {
      return Result<List<Bundle>>.makeError(Exception('El error es este: ${error.toString()}'));
    }
  }
}