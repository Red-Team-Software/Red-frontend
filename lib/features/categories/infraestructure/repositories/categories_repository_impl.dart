import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/categories/domain/datasources/categories_datasource.dart';
import 'package:GoDeli/features/categories/domain/repositories/categories_repository.dart';
import 'package:GoDeli/features/common/domain/result.dart';

class CategoriesRespositoryImpl implements ICategoriesRepository {
  final ICategoriesDatasource categoryDatasource;

  CategoriesRespositoryImpl({required this.categoryDatasource});

  @override
  Future<Result<List<Category>>> getCategories() async {
    try {
      final categories = await categoryDatasource.getCategories();
      return Result<List<Category>>.success(categories);
    } catch (error, _) {
      return Result<List<Category>>.makeError(error as Exception);
    }
  }
  
  @override
  Future<Result<Category>> getCategoryItems(String categoryId) async {
  try {
      final category = await categoryDatasource.getCategoryItems(categoryId);

      return Result<Category>.success(category);
    } catch (error, _) {
      return Result<Category>.makeError(error as Exception);
    }
  }
}
