
import 'package:myapp/feature/product/domain/product.dart';
import 'package:myapp/feature/product/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
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