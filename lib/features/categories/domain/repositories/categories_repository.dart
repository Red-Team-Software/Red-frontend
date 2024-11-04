
import 'package:shopping_cart/features/categories/domain/entities/category.dart';
import 'package:shopping_cart/features/common/result.dart';

abstract class CategoriesRepository {
  Future<Result<List<Category>>> getCategories(
      {});
}