import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/products/domain/product.dart';

abstract class IProductsRepository {
  Future<Result<Product>> getProductById(String id);
  Future<Result<List<Product>>> getProducts();
}
