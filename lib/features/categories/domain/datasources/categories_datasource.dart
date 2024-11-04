import 'package:gymnastic_center/domain/entities/categories/category.dart';

abstract class CategoriesDatasource {
  Future<List<Category>> getCategories(
      {});
}