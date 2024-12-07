import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/common/domain/result.dart';

abstract class ICategoriesDatasource {
  Future<List<Category>> getCategories();
  Future<Result<List<ProductCategory>>> getProductsByCategory(String categoryId);

}