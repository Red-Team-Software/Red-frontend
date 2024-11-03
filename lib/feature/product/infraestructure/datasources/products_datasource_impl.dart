
import 'package:myapp/feature/product/domain/datasource/products_datasource.dart';
import 'package:myapp/feature/product/domain/product.dart';

class ProductsDatasourceImpl implements ProductsDatasource{

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