import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/products/domain/datasource/products_datasource.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/features/products/domain/repositories/products_repository.dart';
import 'package:dio/dio.dart';

class ProductsRepositoryImpl implements IProductsRepository {
  final IProductsDatasource productsDatasource;

  ProductsRepositoryImpl({required this.productsDatasource});

  @override
  Future<Result<Product>> getProductById(String id) async {
    try {
      final product = await productsDatasource.getProductById(id);
      return Result<Product>.success(product);
    } on DioException catch (dioError) {
      return Result<Product>.makeError(Exception('Dio error: ${dioError.message}'));
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
    } on DioException catch (dioError) {
      return Result<List<Product>>.makeError(Exception('Dio error: ${dioError.message}'));
    } catch (error, _) {
      return Result<List<Product>>.makeError(Exception('El error es este: ${error.toString()}'));
    }
  }
  
  @override
  Future<Result<List<Product>>> searchProducts({int page = 1, int perPage = 10, required String term}) async {
    try {
      final products = await productsDatasource.searchProducts(page: page, perPage: perPage, term: term);
      return Result<List<Product>>.success(products);
    } on DioException catch (dioError) {
      return Result<List<Product>>.makeError(Exception('Dio error: ${dioError.toString()}'));
    } catch (error, _) {
      return Result<List<Product>>.makeError(Exception('El error es este: ${error.toString()}'));
    }
  }
}
