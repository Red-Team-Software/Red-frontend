


class CategoriesRespositoryImpl implements CategoriesRepository {
  final CategoriesDatasourceImpl categoryDatasource;

  CategoriesRespositoryImpl({required this.categoryDatasource});

  @override
  Future<Result<List<Category>>> getCategories() async {
    try {
      final categories = await categoryDatasource.getCategories();
      return Result<List<Category>>.success(categories);
    } catch (error, _) {
      return Result<List<Category>>.fail(error as Exception);
    }
  }
}