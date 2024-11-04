import 'package:GoDeli/features/products/domain/product.dart';

abstract class ProductsDatasource {
  Future<Product> getProductById(String id);
  Future<List<Product>> getProducts();
}
