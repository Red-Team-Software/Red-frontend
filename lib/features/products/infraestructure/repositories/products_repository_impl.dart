
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/products/domain/datasource/products_datasource.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/features/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements IProductsRepository {
  final IProductsDatasource productsDatasource;

  ProductsRepositoryImpl({required this.productsDatasource});

  @override
  Future<Result<Product>> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Product>>> getProducts() async {
    try {
      final products = await productsDatasource.getProducts();
      return Result<List<Product>>.success(products);
    } catch (error, _) {
      return Result<List<Product>>.makeError(error as Exception);
    }
  }
}
