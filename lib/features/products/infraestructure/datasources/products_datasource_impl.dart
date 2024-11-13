import 'package:GoDeli/config/constants/enviroments.dart';
import 'package:GoDeli/features/products/domain/datasource/products_datasource.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/features/products/infraestructure/mappers/product_mapper.dart';
import 'package:GoDeli/features/products/infraestructure/models/product_response.dart';
import 'package:dio/dio.dart';

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
  final dio = Dio(BaseOptions(baseUrl: '${Environment.backendApi}/product'));

  ProductsDatasourceImpl();

  @override
  Future<Product> getProductById(String id) async {
    final res = await dio.get('', queryParameters: {'id': id});

    final productRes = ProductResponse.fromJson(res.data);
    return ProductMapper.productToDomian(productRes);
  }

  @override
  Future<List<Product>> getProducts({int page = 1, int perPage = 10}) async {
    final res = await dio.get('/all', queryParameters: {
      'page': page,
      'perPage': perPage,
    });

    final List<Product> products = [];

    for (var product in res.data ?? []) {
      final productRes = ProductResponse.fromJson(product);
      products.add(ProductMapper.productToDomian(productRes));
    }

    return products;
  }
}
