import 'package:GoDeli/feature/product/domain/product.dart';

abstract class ProductsRepository {
  Future<Product> getProductById(String id);
  Future<List<Product>> getProducts();
}
