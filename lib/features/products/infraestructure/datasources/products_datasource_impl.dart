import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/products/domain/datasource/products_datasource.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/features/products/infraestructure/mappers/product_mapper.dart';
import 'package:GoDeli/features/products/infraestructure/models/product_response.dart';
import 'package:GoDeli/features/products/infraestructure/models/search_response.dart';

class ProductsDatasourceImpl implements IProductsDatasource {
  final IHttpService _httpService;

  ProductsDatasourceImpl(this._httpService);

  @override
  Future<Product> getProductById(String id) async {
    var res = await _httpService.request(
        '/product/$id', 'GET', (json) => ProductResponse.fromJson(json));
    return ProductMapper.productToDomain(res.getValue());
  }

  @override
  Future<List<Product>> getProducts(
      {List<String>? category,
      double? discount,
      int page = 1,
      int perPage = 10,
      String? popular,
      double? price,
      String? term
      }) async {
    final res = await _httpService.request(
        '/product/many', 'GET', (json) => ProductResponse.fromJsonList(json),
        queryParameters: {
          'page': page,
          'perpage': perPage,
          if (discount != null) 'discount': discount,
          if (category != null) 'category': category,
          if (popular != null) 'popular': popular,
          if (price != null) 'price': price,
          if (term != null) 'name': term
        });

    final List<Product> products = [];

    if (res.isSuccessful()) {
      for (var product in res.getValue()) {
        products.add(ProductMapper.productToDomain(product));
      }
    }

    return products;
  }

  @override
  Future<List<Product>> searchProducts(
      {int page = 1, int perPage = 10, required String term}) async {
    final resProduct = await _httpService.request('/product/all-product-bundle',
        'GET', (json) => SearchResponse.fromJson(json),
        queryParameters: {'page': page, 'perpage': perPage, 'term': term});

    // print(res);
    final List<Product> products = [];

    if (resProduct.isSuccessful()) {
      for (var product in resProduct.getValue().products) {
        products.add(ProductMapper.productToDomain(product));
      }
    }
    return products;
  }
}
