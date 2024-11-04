//import 'package:dio/dio.dart';
import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/categories/domain/datasources/categories_datasource.dart';

List<Category> categories = [
  Category(
      id: '1',
      name: 'Electronics',
      icon:
          'https://t3.ftcdn.net/jpg/05/12/04/44/240_F_512044433_p0KqZnsAENoQ5avPXt9rn3YU5JeeYeC3.jpg'),
  Category(
      id: '2',
      name: 'Food',
      icon:
          'https://t3.ftcdn.net/jpg/05/12/04/44/240_F_512044433_p0KqZnsAENoQ5avPXt9rn3YU5JeeYeC3.jpg'),
  Category(
      id: '3',
      name: 'Otra',
      icon:
          'https://t3.ftcdn.net/jpg/05/12/04/44/240_F_512044433_p0KqZnsAENoQ5avPXt9rn3YU5JeeYeC3.jpg'),
  Category(
      id: '4',
      name: 'Otra',
      icon:
          'https://t3.ftcdn.net/jpg/05/12/04/44/240_F_512044433_p0KqZnsAENoQ5avPXt9rn3YU5JeeYeC3.jpg'),
  Category(
      id: '5',
      name: 'Otra',
      icon:
          'https://t3.ftcdn.net/jpg/05/12/04/44/240_F_512044433_p0KqZnsAENoQ5avPXt9rn3YU5JeeYeC3.jpg'),
];

class CategoriesDatasourceImpl implements ICategoriesDatasource {
  //final dio = Dio(BaseOptions(baseUrl: '${Environment.backendApi}/category'));

  @override
  Future<List<Category>> getCategories() {
    return Future.value(categories);
  }
}
