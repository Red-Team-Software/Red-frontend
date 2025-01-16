import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/bundles/domain/datasources/bundle_datasource.dart';
import 'package:GoDeli/features/bundles/infraestructure/mappers/bundle_mapper.dart';
import 'package:GoDeli/features/bundles/infraestructure/models/bundle_response.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';

class BundlesDatasourceImpl implements IBundleDatasource {
  final IHttpService _httpService;

  BundlesDatasourceImpl(this._httpService);

  @override
  Future<Bundle> getBundleById(String id) async {
    final res = await _httpService.request(
        '/bundle/$id', 'GET', (json) => BundleResponse.fromJson(json));

    return BundleMapper.bundleToDomian(res.getValue());
  }

  @override
  Future<List<Bundle>> getBundlesPaginated(
      {int page = 1,
      int perPage = 10,
      List<String>? category,
      String? popular,
      double? discount,
      double? price,
      String? term
      }) async {
    final res = await _httpService.request(
        '/bundle/many', 'GET', (json) => BundleResponse.fromJsonList(json),
        queryParameters: {
          'page': page,
          'perpage': perPage,
          if (discount != null) 'discount': discount,
          if (category != null) 'category': category,
          if (popular != null) 'popular': popular,
          if (price != null) 'price': price,
          if (term != null) 'name': term
        });

    final List<Bundle> bundles = [];

    for (var bun in res.getValue()) {
      bundles.add(BundleMapper.bundleToDomian(bun));
    }

    return bundles;
  }

  @override
  Future<List<Bundle>> searchBundles(
      {int page = 1, int perPage = 10, required String term}) async {
    final resBundles = await _httpService.request(
        '/bundle/all-name', 'GET', (json) => BundleResponse.fromJsonList(json),
        queryParameters: {'page': page, 'perpage': perPage, 'term': term});

    // print(res);
    final List<Bundle> bundles = [];

    if (resBundles.isSuccessful()) {
      for (var bun in resBundles.getValue()) {
        bundles.add(BundleMapper.bundleToDomian(bun));
      }
    }
    return bundles;
  }
}
