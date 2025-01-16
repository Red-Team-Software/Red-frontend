import 'package:GoDeli/features/products/domain/product.dart';

abstract class IProductsDatasource {
  Future<Product> getProductById(String id);
  Future<List<Product>> getProducts(
      {int page = 1,
      int perPage = 10,
      List<String>? category,
      String? popular,
      double? discount,
      double? price,
      String? term});
  Future<List<Product>> searchProducts(
      {int page = 1, int perPage = 10, required String term});
}
