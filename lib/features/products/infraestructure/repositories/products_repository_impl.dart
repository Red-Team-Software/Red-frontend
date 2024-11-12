import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/products/domain/datasource/products_datasource.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/features/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements IProductsRepository {
  final IProductsDatasource productsDatasource;

  ProductsRepositoryImpl({required this.productsDatasource});

  @override
  Future<Result<Product>> getProductById(String id) async {
    try {
      final product = await productsDatasource.getProductById(id);
      return Result<Product>.success(product);
    } catch (error, _) {
      return Result<Product>.makeError(error as Exception);
    }
  }

  @override
  Future<Result<List<Product>>> getProducts(
      {int page = 1, int perPage = 10}) async {
    try {
      final products =
          await productsDatasource.getProducts(page: page, perPage: perPage);
      return Result<List<Product>>.success(products);
    } catch (error, _) {
      print("el error es");
      print(error);
      return Result<List<Product>>.makeError(error as Exception);
    }
  }
}
