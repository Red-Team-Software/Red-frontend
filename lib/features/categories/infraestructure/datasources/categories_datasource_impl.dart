//import 'package:dio/dio.dart';
import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/categories/domain/datasources/categories_datasource.dart';
import 'package:GoDeli/features/categories/infraestructure/mappers/category_mapper.dart';
import 'package:GoDeli/features/categories/infraestructure/models/category_response.dart';
import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';

// List<Category> categories = [
//   Category(
//       id: '1',
//       name: 'Electronics',
//       icon:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuv4A_auLKEOA236YRTj1YRNWg03Uqvr1bLg&s'),
//   Category(
//       id: '2',
//       name: 'Food',
//       icon:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStOB26e6FqhS8YWtkvN0L3cbFpupGF5VN8XA&s'),
//   Category(
//       id: '3',
//       name: 'Bebidas',
//       icon:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUZgbTDkQnOaT6Sc-zDk0B0sBCnast2TzpBA&s'),
//   Category(
//       id: '4',
//       name: 'Ropa',
//       icon: 'https://cdn-icons-png.flaticon.com/512/1381/1381792.png'),
//   Category(
//       id: '5',
//       name: 'Otra',
//       icon:
//           'https://t3.ftcdn.net/jpg/05/12/04/44/240_F_512044433_p0KqZnsAENoQ5avPXt9rn3YU5JeeYeC3.jpg'),
// ];

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
