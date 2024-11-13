

import 'package:GoDeli/config/constants/enviroments.dart';
import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/bundles/domain/datasources/bundle_datasource.dart';
import 'package:GoDeli/features/bundles/infraestructure/mappers/bundle_mapper.dart';
import 'package:GoDeli/features/bundles/infraestructure/models/bundle_response.dart';
import 'package:dio/dio.dart';

class BundlesDatasourceImpl implements IBundleDatasource{

  final dio = Dio(BaseOptions(baseUrl: '${Environment.backendApi}/bundle'));


  @override
  Future<Bundle> getBundleById(String id) {
    // TODO: implement getBundleById
    throw UnimplementedError();
  }

  @override
  Future<List<Bundle>> getBundlesPaginated({int page = 1, int perPage = 10}) async {
    final res = await dio.get('/all', queryParameters: {
      'page': page,
      'perPage': perPage,
    });

    final List<Bundle> bundles = [];

    for (var bun in res.data ?? []) {
      final bunRes = BundleResponse.fromJson(bun);
      bundles.add(BundleMapper.bundleToDomian(bunRes));
    }

    return bundles;
  }
}