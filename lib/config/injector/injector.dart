import 'package:GoDeli/config/locar_storage/isar_local_storage.dart';
import 'package:GoDeli/features/auth/application/bloc/auth_bloc.dart';
import 'package:GoDeli/features/auth/application/datasources/auth_datasource.dart';
import 'package:GoDeli/features/auth/application/datasources/auth_local_storage_datasource.dart';
import 'package:GoDeli/features/auth/application/repositories/auth_local_storage_repository.dart';
import 'package:GoDeli/features/auth/application/repositories/auth_repository.dart';
import 'package:GoDeli/features/auth/application/use_cases/login_use_case.dart';
import 'package:GoDeli/features/auth/application/use_cases/register_use_case.dart';
import 'package:GoDeli/features/auth/infrastructure/datasource/auth_datasource.dart';
import 'package:GoDeli/features/auth/infrastructure/datasource/isar_auth_local_storage_datasource.dart';
import 'package:GoDeli/features/auth/infrastructure/repository/auth_repository.dart';
import 'package:GoDeli/features/auth/infrastructure/repository/isar_auth_local_storage_repository.dart';
import 'package:GoDeli/features/bundles/application/bundle_details/bundle_details_bloc.dart';
import 'package:GoDeli/features/bundles/application/bundles/all_bundles_bloc.dart';
import 'package:GoDeli/features/bundles/domain/repositories/bundle_repository.dart';
import 'package:GoDeli/features/bundles/infraestructure/datasources/bundles_datasource_impl.dart';
import 'package:GoDeli/features/bundles/infraestructure/repositories/bundle_repository_impl.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/cart/infraestructure/datasources/cart_isar_local_storage_datasource.dart';
import 'package:GoDeli/features/cart/infraestructure/repositories/cart_local_storage_repository_impl.dart';
import 'package:GoDeli/features/categories/application/categories_bloc.dart';
import 'package:GoDeli/features/categories/domain/repositories/categories_repository.dart';
import 'package:GoDeli/features/categories/infraestructure/datasources/categories_datasource_impl.dart';
import 'package:GoDeli/features/categories/infraestructure/repositories/categories_repository_impl.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/common/infrastructure/dio_http_service_impl.dart';
import 'package:GoDeli/features/order/domain/repositories/order_repository.dart';
import 'package:GoDeli/features/order/infraestructure/datasource/order_datasource_imp.dart';
import 'package:GoDeli/features/order/infraestructure/repositories/order_repository_imp.dart';
import 'package:GoDeli/features/products/application/productDetails/product_details_bloc.dart';
import 'package:GoDeli/features/products/application/products/all_products_bloc.dart';
import 'package:GoDeli/features/products/domain/repositories/products_repository.dart';
import 'package:GoDeli/features/products/infraestructure/datasources/products_datasource_impl.dart';
import 'package:GoDeli/features/products/infraestructure/repositories/products_repository_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class Injector {
  Future<void> setUp() async {
    //? inicializando las dependencias de modulo comun
    final httpService = DioHttpServiceImpl();
    getIt.registerSingleton<IHttpService>(httpService);

    final isarLocalStorage = IsarLocalStorage();
    getIt.registerSingleton<IsarLocalStorage>(isarLocalStorage);

    //? inicializando las dependencias de modulo autenticacion
    final IAuthDataSource authDataSource = AuthDatasource(httpService);
    final IAuthRepository authRepository = AuthRepository(authDataSource);
    final IAuthLocalStorageDataSource authLocalStorageDataSource =
        IsarAuthLocalStorageDatasource(isarLocalStorage);
    final IAuthLocalStorageRepository authLocalStorageRepository =
        IsarAuthLocalStorageRepository(authLocalStorageDataSource);
    final LoginUseCase loginUseCase =
        LoginUseCase(authRepository, authLocalStorageRepository);
    final RegisterUseCase registerUseCase =
        RegisterUseCase(authRepository, authLocalStorageRepository);
    getIt.registerSingleton<IAuthRepository>(authRepository);
    getIt.registerFactory<AuthBloc>(() =>
        AuthBloc(loginUseCase: loginUseCase, registerUseCase: registerUseCase));

    final token = await authLocalStorageRepository.getToken();
    if (token != '') {
      httpService.addHeader('Authorization', 'Bearer $token');
    }

    //? inicializando las dependencias de modulo categorias

    final categoryDatasource = CategoriesDatasourceImpl();
    final categoriesRepository =
        CategoriesRespositoryImpl(categoryDatasource: categoryDatasource);
    getIt.registerFactory<ICategoriesRepository>(() => categoriesRepository);
    getIt.registerFactory<CategoriesBloc>(
        () => CategoriesBloc(categoryRepository: categoriesRepository));

    //? inicializando las dependencias de modulo productos
    final productsDatasource = ProductsDatasourceImpl(httpService);
    final productsRepository =
        ProductsRepositoryImpl(productsDatasource: productsDatasource);

    getIt.registerFactory<IProductsRepository>(() => productsRepository);
    getIt.registerFactory<AllProductsBloc>(
        () => AllProductsBloc(productsRepository: productsRepository));
    getIt.registerFactory<ProductDetailsBloc>(
        () => ProductDetailsBloc(productsRepository: productsRepository));

    //? inicializando las dependencias de modulo combos
    final bundleDatasource = BundlesDatasourceImpl(httpService);
    final bundleRepository =
        BundleRepositoryImpl(bundleDatasource: bundleDatasource);
    getIt.registerFactory<IBundleRepository>(() => bundleRepository);
    getIt.registerFactory<AllBundlesBloc>(
        () => AllBundlesBloc(bundleRepository: bundleRepository));
    getIt.registerFactory<BundleDetailsBloc>(
        () => BundleDetailsBloc(bundleRepository: bundleRepository));

    //? inicializando las dependencias de modulo carrito
    final datasource = CartIsarLocalStorageDatasource(isarLocalStorage);
    CartLocalStorageRepositoryImpl repository =
        CartLocalStorageRepositoryImpl(dataSource: datasource);
    getIt.registerSingleton<CartBloc>(CartBloc(repository: repository));

    //? Iiniciando las dependencias de modulo de orden

    final orderDatasource = OrderDatasourceImpl();
    final orderRepository = OrderRepositoryImpl(datasource: orderDatasource);

    getIt.registerFactory<IOrderRepository>(() => orderRepository);
  }
}
