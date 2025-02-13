import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/products/domain/product.dart';

abstract class IProductsRepository {
  Future<Result<Product>> getProductById(String id);
  Future<Result<List<Product>>> getProducts(
      {int page = 1,
      int perPage = 10,
      List<String>? category,
      String? popular,
      double? discount,
      double? price,
      String? term});
  Future<Result<List<Product>>> searchProducts(
      {int page = 1, int perPage = 10, required String term});
}
