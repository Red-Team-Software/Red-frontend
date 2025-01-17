import 'package:GoDeli/features/categories/domain/category.dart';

abstract class ICategoriesDatasource {
  Future<List<Category>> getCategories();
  Future<Category> getCategoryItems(String categoryId);
}
