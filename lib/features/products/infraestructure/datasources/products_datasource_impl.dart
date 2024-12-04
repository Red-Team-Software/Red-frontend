import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/products/domain/datasource/products_datasource.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/features/products/infraestructure/mappers/product_mapper.dart';
import 'package:GoDeli/features/products/infraestructure/models/product_response.dart';

// final List<Product> mockProducts = [
//   Product(
//       id: '1',
//       name: 'Frutas',
//       description: 'Frutas calidad precio increibles',
//       price: 20.25,
//       imageUrl: [
//         'https://s3.abcstatics.com/media/bienestar/2021/09/22/frutas-kfNH--1248x698@abc.jpg'
//       ]),
//       Product(
//       id: '2',
//       name: 'Otras Frutas',
//       description: 'Otras Frutas calidad precio increibles',
//       price: 20.25,
//       imageUrl: [
//         'https://s3.abcstatics.com/media/bienestar/2021/09/22/frutas-kfNH--1248x698@abc.jpg'
//       ]),
//       Product(
//       id: '3',
//       name: 'Otras Frutas',
//       description: 'Otras Frutas calidad precio increibles',
//       price: 20.25,
//       imageUrl: [
//         'https://s3.abcstatics.com/media/bienestar/2021/09/22/frutas-kfNH--1248x698@abc.jpg'
//       ])
// ];

class ProductsDatasourceImpl implements IProductsDatasource {
  final IHttpService _httpService;

  ProductsDatasourceImpl(this._httpService);

  @override
  Future<Product> getProductById(String id) async {
    final res = await _httpService.request(
        '/product/', 'GET', (json) => ProductResponse.fromJson(json),
        queryParameters: {'id': id});
    // final res = await dio.get('', queryParameters: {'id': id});
    // final productRes = ProductResponse.fromJson(res.data);
    return ProductMapper.productToDomain(res.getValue());
  }

  @override
  Future<List<Product>> getProducts({int page = 1, int perPage = 10}) async {

    final res = await _httpService.request(
        '/product/all', 'GET', (json) => ProductResponse.fromJsonList(json),
        queryParameters: {
          'page': page,
          'perPage': perPage,
        });

    // final res = await dio.get('/product/all', queryParameters: {
    //   'page': page,
    //   'perPage': perPage,
    // });

    final List<Product> products = [];

    for (var product in res.getValue()) {

      products.add(ProductMapper.productToDomain(product));
    }

    return products;
  }
}
