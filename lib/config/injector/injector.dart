import 'package:GoDeli/features/categories/application/categories_bloc.dart';
import 'package:GoDeli/features/categories/domain/repositories/categories_repository.dart';
import 'package:GoDeli/features/categories/infraestructure/datasources/categories_datasource_impl.dart';
import 'package:GoDeli/features/categories/infraestructure/repositories/categories_repository_impl.dart';
import 'package:GoDeli/features/products/application/productDetails/product_details_bloc.dart';
import 'package:GoDeli/features/products/application/products/all_products_bloc.dart';
import 'package:GoDeli/features/products/domain/repositories/products_repository.dart';
import 'package:GoDeli/features/products/infraestructure/datasources/products_datasource_impl.dart';
import 'package:GoDeli/features/products/infraestructure/repositories/products_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
final dio = Dio();

class Injector {
  void setUp() {
    //? inicializando las dependencias de modulo categorias
    final categoryDatasource = CategoriesDatasourceImpl();
    final categoriesRepository =
        CategoriesRespositoryImpl(categoryDatasource: categoryDatasource);
    getIt.registerFactory<ICategoriesRepository>(() => categoriesRepository);
    getIt.registerFactory<CategoriesBloc>(
        () => CategoriesBloc(categoryRepository: categoriesRepository));

    //? inicializando las dependencias de modulo productos
    final productsDatasource = ProductsDatasourceImpl();
    final productsRepository =
        ProductsRepositoryImpl(productsDatasource: productsDatasource);

    getIt.registerFactory<IProductsRepository>(() => productsRepository);
    getIt.registerFactory<AllProductsBloc>(
        () => AllProductsBloc(productsRepository: productsRepository));
    getIt.registerFactory<ProductDetailsBloc>(
        () => ProductDetailsBloc(productsRepository: productsRepository));
  }
}
