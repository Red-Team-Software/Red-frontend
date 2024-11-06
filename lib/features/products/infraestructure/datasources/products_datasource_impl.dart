import 'package:GoDeli/features/products/domain/datasource/products_datasource.dart';
import 'package:GoDeli/features/products/domain/product.dart';

final List<Product> mockProducts = [
  Product(
      id: '1',
      name: 'Frutas',
      description: 'Frutas calidad precio increibles',
      price: 20.25,
      imageUrl: [
        'https://s3.abcstatics.com/media/bienestar/2021/09/22/frutas-kfNH--1248x698@abc.jpg'
      ]),
      Product(
      id: '2',
      name: 'Otras Frutas',
      description: 'Otras Frutas calidad precio increibles',
      price: 20.25,
      imageUrl: [
        'https://s3.abcstatics.com/media/bienestar/2021/09/22/frutas-kfNH--1248x698@abc.jpg'
      ]),
      Product(
      id: '3',
      name: 'Otras Frutas',
      description: 'Otras Frutas calidad precio increibles',
      price: 20.25,
      imageUrl: [
        'https://s3.abcstatics.com/media/bienestar/2021/09/22/frutas-kfNH--1248x698@abc.jpg'
      ])
];

class ProductsDatasourceImpl implements IProductsDatasource {
  @override
  Future<Product> getProductById(String id) {
    // TODO: implement getProductById

    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProducts() async{
    await  Future.delayed(const Duration(seconds:2));

    return mockProducts;
  }
}
