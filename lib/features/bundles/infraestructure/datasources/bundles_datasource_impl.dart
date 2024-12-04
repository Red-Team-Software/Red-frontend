

import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/bundles/domain/datasources/bundle_datasource.dart';
import 'package:GoDeli/features/bundles/infraestructure/mappers/bundle_mapper.dart';
import 'package:GoDeli/features/bundles/infraestructure/models/bundle_response.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';

class BundlesDatasourceImpl implements IBundleDatasource{

  final IHttpService _httpService;

  BundlesDatasourceImpl(this._httpService);



  @override
  Future<Bundle> getBundleById(String id) async {

    final res = await _httpService.request(
        '/bundle/', 'GET', (json) => BundleResponse.fromJson(json),
        queryParameters: {'id': id});

    return BundleMapper.bundleToDomian(res.getValue());
  }

  @override
  Future<List<Bundle>> getBundlesPaginated({int page = 1, int perPage = 10}) async {
    
    final res = await _httpService.request(
        '/bundle/all', 'GET', (json) => BundleResponse.fromJsonList(json),
        queryParameters: {
          'page': page,
          'perPage': perPage,
        });
    
    // final res = await dio.get('/all', queryParameters: {
    //   'page': page,
    //   'perPage': perPage,
    // });

    final List<Bundle> bundles = [];

    for (var bun in res.getValue()) {
      bundles.add(BundleMapper.bundleToDomian(bun));
    }

    return bundles;
  }
}