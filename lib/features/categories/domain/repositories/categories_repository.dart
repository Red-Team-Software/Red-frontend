import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/common/domain/result.dart';

abstract class ICategoriesRepository {
  Future<Result<List<Category>>> getCategories();
  Future<Result<List<ProductCategory>>> getProductsByCategory(String categoryId);
}
