import 'package:GoDeli/features/categories/application/categories_bloc.dart';
import 'package:GoDeli/features/categories/infraestructure/datasources/categories_datasource_impl.dart';
import 'package:GoDeli/features/categories/infraestructure/repositories/categories_repository_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class Injector {
  void setUp() {
    //? inicializando las dependencias de modulo child
    final categoryDatasource = CategoriesDatasourceImpl();
    final categoriesRepository =
        CategoriesRespositoryImpl(categoryDatasource: categoryDatasource);
    getIt.registerFactory(() => categoriesRepository);
    getIt.registerFactory<CategoriesBloc>(
        () => CategoriesBloc(categoryRepository: categoriesRepository));
  }
}
