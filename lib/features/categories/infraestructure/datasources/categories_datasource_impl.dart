//import 'package:dio/dio.dart';
import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/categories/domain/datasources/categories_datasource.dart';
import 'package:GoDeli/features/categories/infraestructure/mappers/category_mapper.dart';
import 'package:GoDeli/features/categories/infraestructure/models/category_response.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';

class CategoriesDatasourceImpl implements ICategoriesDatasource {

  final IHttpService _httpService;

  CategoriesDatasourceImpl(this._httpService);

  @override
  Future<List<Category>> getCategories() async{

    final res = await _httpService.request(
        '/category/many', 'GET', (json) => CategoryResponse.fromJsonList(json),
        queryParameters: {
          'page': 1,
          'perPage': 10,
        });

    final List<Category> categories = [];

    if( res.isSuccessful() ) {
      for (var cat in res.getValue()) {
        categories.add(CategoryMapper.categoryToDomian(cat));
      }
    }

    return categories;
  }

  @override
  Future<Result<List<ProductCategory>>> getProductsByCategory(String categoryId) {
    // TODO: implement getProductsByCategory
    throw UnimplementedError();
  }
}
