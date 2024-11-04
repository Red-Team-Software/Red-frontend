import 'package:dio/dio.dart';
//import 'package:shopping_cart/core/error/exceptions.dart';
import 'package:shopping_cart/features/categories/domain/category.dart';
import 'package:shopping_cart/features/categories/domain/datasources/category_datasource.dart';


const List<Category> categories = [
  Category(id: '1', name: 'Electronics',),
];

class CategoryDatasourceImpl implements CategoryDatasource {

  //final dio = Dio(BaseOptions(baseUrl: '${Environment.backendApi}/category'));

  CategoryDatasourceImpl(this.dio);

  @override
  Future<List<Category>> getCategories() async {
    
  }
}