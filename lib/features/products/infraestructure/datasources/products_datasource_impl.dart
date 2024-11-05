import 'package:GoDeli/features/products/domain/datasource/products_datasource.dart';
import 'package:GoDeli/features/products/domain/product.dart';

final List<Product> mockProducts = [
  Product(
      id: '1',
      name: 'Laptop',
      description: 'Laptop gaming',
      price: 720.25,
      imageUrl: [
        'https://www.laserprintsoluciones.com/wp-content/uploads/2022/08/L352i7TGs8256W11D1WXCTO-1.png'
      ]),
];

class ProductsDatasourceImpl implements IProductsDatasource {
  @override
  Future<Product> getProductById(String id) {
    // TODO: implement getProductById

    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }
}
