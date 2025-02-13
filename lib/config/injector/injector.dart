import 'package:GoDeli/config/constants/enviroments.dart';
import 'package:GoDeli/config/locar_storage/isar_local_storage.dart';
import 'package:GoDeli/features/auth/application/bloc/auth_bloc.dart';
import 'package:GoDeli/features/auth/application/datasources/auth_datasource.dart';
import 'package:GoDeli/features/auth/application/datasources/auth_local_storage_datasource.dart';
import 'package:GoDeli/features/auth/application/repositories/auth_local_storage_repository.dart';
import 'package:GoDeli/features/auth/application/repositories/auth_repository.dart';
import 'package:GoDeli/features/auth/application/use_cases/check_auth_use_case.dart';
import 'package:GoDeli/features/auth/application/use_cases/log_out_use_case.dart';
import 'package:GoDeli/features/auth/application/use_cases/login_use_case.dart';
import 'package:GoDeli/features/auth/application/use_cases/register_use_case.dart';
import 'package:GoDeli/features/auth/application/use_cases/update_image_use_case.dart';
import 'package:GoDeli/features/auth/infrastructure/datasource/auth_datasource.dart';
import 'package:GoDeli/features/auth/infrastructure/datasource/isar_auth_local_storage_datasource.dart';
import 'package:GoDeli/features/auth/infrastructure/repository/auth_repository.dart';
import 'package:GoDeli/features/auth/infrastructure/repository/isar_auth_local_storage_repository.dart';
import 'package:GoDeli/features/bundles/application/bundle_details/bundle_details_bloc.dart';
import 'package:GoDeli/features/bundles/application/bundle_offers/bundle_offers_bloc.dart';
import 'package:GoDeli/features/bundles/application/bundles/all_bundles_bloc.dart';
import 'package:GoDeli/features/bundles/domain/repositories/bundle_repository.dart';
import 'package:GoDeli/features/bundles/infraestructure/datasources/bundles_datasource_impl.dart';
import 'package:GoDeli/features/bundles/infraestructure/repositories/bundle_repository_impl.dart';
import 'package:GoDeli/features/card/aplication/Blocs/card_bloc.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/cart/infraestructure/datasources/cart_isar_local_storage_datasource.dart';
import 'package:GoDeli/features/cart/infraestructure/repositories/cart_local_storage_repository_impl.dart';
import 'package:GoDeli/features/catalog/bloc/catalog_bloc.dart';
import 'package:GoDeli/features/categories/application/all-categories/categories_bloc.dart';
import 'package:GoDeli/features/categories/domain/repositories/categories_repository.dart';
import 'package:GoDeli/features/categories/infraestructure/datasources/categories_datasource_impl.dart';
import 'package:GoDeli/features/categories/infraestructure/repositories/categories_repository_impl.dart';
import 'package:GoDeli/features/common/application/bloc/select_datasource_bloc_bloc.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/common/infrastructure/dio_http_service_impl.dart';
import 'package:GoDeli/features/order/domain/repositories/order_repository.dart';
import 'package:GoDeli/features/order/infraestructure/datasource/order_datasource_imp.dart';
import 'package:GoDeli/features/order/infraestructure/repositories/order_repository_imp.dart';
import 'package:GoDeli/features/orders/aplication/Bloc/orders_bloc.dart';
import 'package:GoDeli/features/payment-method/application/bloc/payment_method_bloc.dart';
import 'package:GoDeli/features/payment-method/application/use_cases/get_payment_methods_use_case.dart';
import 'package:GoDeli/features/payment-method/domain/repositories/payment-method_repository.dart';
import 'package:GoDeli/features/payment-method/infraestructure/datasource/payment-method_datasource_imp.dart';
import 'package:GoDeli/features/payment-method/infraestructure/repositories/payment-method_respository_imp.dart';
import 'package:GoDeli/features/products/application/popular_products/popular_products_bloc.dart';
import 'package:GoDeli/features/products/application/productDetails/product_details_bloc.dart';
import 'package:GoDeli/features/products/application/products/all_products_bloc.dart';
import 'package:GoDeli/features/products/domain/repositories/products_repository.dart';
import 'package:GoDeli/features/products/infraestructure/datasources/products_datasource_impl.dart';
import 'package:GoDeli/features/products/infraestructure/repositories/products_repository_impl.dart';
import 'package:GoDeli/features/search/application/bloc/bloc.dart';
import 'package:GoDeli/features/tax-shipping/domain/repositories/tax-shipping_repository.dart';
import 'package:GoDeli/features/tax-shipping/infraestructure/datasource/tax_shipping_datasource_imp.dart';
import 'package:GoDeli/features/tax-shipping/infraestructure/repositories/tax-shipping_repository_imp.dart';
import 'package:GoDeli/features/user/application/bloc/user_bloc.dart';
import 'package:GoDeli/features/user/application/use_cases/add_user_direction_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/delete_user_direction_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/get_user_directions_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/get_user_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/update_user_direction_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/update_user_use_case.dart';
import 'package:GoDeli/features/user/domain/datasources/user_datasource.dart';
import 'package:GoDeli/features/user/domain/repositories/user_repository.dart';
import 'package:GoDeli/features/user/infrastructure/datasources/user_datasource_impl.dart';
import 'package:GoDeli/features/user/infrastructure/repositories/user_repository_impl.dart';
import 'package:GoDeli/features/wallet/application/bloc/wallet_bloc.dart';
import 'package:GoDeli/features/wallet/application/datasource/wallet_datasource.dart';
import 'package:GoDeli/features/wallet/application/repository/wallet_repository.dart';
import 'package:GoDeli/features/wallet/application/use_cases/pay_pago_movil_use_case.dart';
import 'package:GoDeli/features/wallet/application/use_cases/pay_zelle_use_case.dart';
import 'package:GoDeli/features/wallet/infrastructure/datasource/wallet_datasource_impl.dart';
import 'package:GoDeli/features/wallet/infrastructure/repository/wallet_repository_impl.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:GoDeli/features/card/domain/datasource/card_datasource.dart';
import 'package:GoDeli/features/card/domain/repositories/card_repository.dart';
import 'package:GoDeli/features/card/infraestructure/datasource/card_datasource_imp.dart';
import 'package:GoDeli/features/card/infraestructure/repositories/card_repository_imp.dart';

final getIt = GetIt.instance;

class Injector {
  Future<void> setUp() async {
    final selectDatasourceBloc = SelectDatasourceBloc();

    await Environment.initEnvironment(selectDatasourceBloc);

    //? Iniciando modulo de Stripe

    Stripe.publishableKey = Environment.getStripePublishableKey();
    await Stripe.instance.applySettings();

    //? inicializando las dependencias de modulo comun
    final httpService = DioHttpServiceImpl();
    // getIt.registerSingleton<IHttpService>(httpService);

    final isarLocalStorage = IsarLocalStorage();
    getIt.registerSingleton<IsarLocalStorage>(isarLocalStorage);

    //? inicializando las dependencias de modulo carrito
    final cartDatasource = CartIsarLocalStorageDatasource(isarLocalStorage);
    CartLocalStorageRepositoryImpl cartRepository =
        CartLocalStorageRepositoryImpl(dataSource: cartDatasource);
    getIt.registerSingleton<CartBloc>(CartBloc(repository: cartRepository));

    //? inicializando las dependencias de modulo usuario
    final IUserDatasource userDatasource = UserDatasourceImpl(httpService);
    final IUserRepository userRepository = UserRepositoryImpl(userDatasource);
    final GetUserUseCase getUserUseCase = GetUserUseCase(userRepository);
    final UpdateUserUseCase updateUserUseCase =
        UpdateUserUseCase(userRepository);
    final GetUserDirectionsUseCase getUserDirectionsUseCase =
        GetUserDirectionsUseCase(userRepository);
    final AddUserDirectionUseCase addUserDirectionUseCase =
        AddUserDirectionUseCase(userRepository);
    final DeleteUserDirectionUseCase deleteUserDirectionUseCase =
        DeleteUserDirectionUseCase(userRepository);
    final UpdateUserDirectionUseCase updateUserDirectionUseCase =
        UpdateUserDirectionUseCase(userRepository);

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
    final LogoutUseCase logoutUseCase =
        LogoutUseCase(httpService, authLocalStorageRepository, cartRepository);
    final CheckAuthUseCase checkAuthUseCase = CheckAuthUseCase(
        httpService, authLocalStorageRepository, cartRepository);
    final UpdateImageUseCase updateImageUseCase =
        UpdateImageUseCase(userRepository);

    // getIt.registerSingleton<IAuthRepository>(authRepository);
    getIt.registerFactory<AuthBloc>(() => AuthBloc(
        loginUseCase: loginUseCase,
        registerUseCase: registerUseCase,
        logoutUseCase: logoutUseCase,
        checkAuthUseCase: checkAuthUseCase,
        updateUserUseCase: updateUserUseCase,
        addUserDirectionUseCase: addUserDirectionUseCase,
        updateimageUseCase: updateImageUseCase
        ));

    getIt.registerFactory<UserBloc>(() => UserBloc(
        getUserUseCase: getUserUseCase,
        updateUserUseCase: updateUserUseCase,
        getUserDirectionsUseCase: getUserDirectionsUseCase,
        addUserDirectionUseCase: addUserDirectionUseCase,
        deleteUserDirectionUseCase: deleteUserDirectionUseCase,
        updateUserDirectionUseCase: updateUserDirectionUseCase));

    //? inicializando las dependencias de modulo categorias
    final categoryDatasource = CategoriesDatasourceImpl(httpService);
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
    getIt.registerFactory<PopularProductsBloc>(
        () => PopularProductsBloc(productsRepository: productsRepository));

    //? inicializando las dependencias de modulo combos
    final bundleDatasource = BundlesDatasourceImpl(httpService);
    final bundleRepository =
        BundleRepositoryImpl(bundleDatasource: bundleDatasource);
    getIt.registerFactory<IBundleRepository>(() => bundleRepository);
    getIt.registerFactory<AllBundlesBloc>(
        () => AllBundlesBloc(bundleRepository: bundleRepository));
    getIt.registerFactory<BundleDetailsBloc>(
        () => BundleDetailsBloc(bundleRepository: bundleRepository));
    getIt.registerFactory<BundleOffersBloc>(
        () => BundleOffersBloc(bundleRepository: bundleRepository));

    //? inicializando las dependencias de modulo search
    getIt.registerFactory<SearchBloc>(
        () => SearchBloc(productsRepository, bundleRepository));

    //? inicializando las dependencias del modulo catalogo
    getIt.registerFactory<CatalogBloc>(() => CatalogBloc(
        productsRepository: productsRepository,
        bundleRepository: bundleRepository));

    //? Iiniciando las dependencias de modulo de orden

    final paymentMethodDataSource = PaymentMethodDatasourceImpl(httpService);
    final paymentMethodRepository = PaymentMethodRepositoryImpl(
        paymentMethodDatasource: paymentMethodDataSource);
    final orderDatasource = OrderDatasourceImpl(httpService: httpService);
    final orderRepository = OrderRepositoryImpl(datasource: orderDatasource);
    final getPaymentMethodsUseCase =
        GetPaymentMethodsUseCase(paymentMethodRepository);

    getIt.registerSingleton<GetUserDirectionsUseCase>(getUserDirectionsUseCase);
    getIt.registerSingleton<AddUserDirectionUseCase>(addUserDirectionUseCase);
    getIt.registerSingleton<DeleteUserDirectionUseCase>(
        deleteUserDirectionUseCase);
    getIt.registerSingleton<UpdateUserDirectionUseCase>(
        updateUserDirectionUseCase);

    getIt.registerFactory<IOrderRepository>(() => orderRepository);
    getIt.registerFactory<IPaymentMethodRepository>(
        () => paymentMethodRepository);
    getIt.registerFactory<PaymentMethodBloc>(() =>
        PaymentMethodBloc(getPaymentMethodsUseCase: getPaymentMethodsUseCase));

    //? inicializando las dependencias de modulo tax y shipping
    final taxShippingDatasource =
        TaxShippingDatasourceImpl(httpService: httpService);
    final taxShippingRepository =
        TaxShippingRepositoryImpl(datasource: taxShippingDatasource);
    getIt.registerFactory<ITaxShippinRepository>(() => taxShippingRepository);

    //? inicializando las dependencias de modulo ordenes
    getIt.registerFactory<OrdersBloc>(
        () => OrdersBloc(orderRepository: orderRepository));

    //? inicializando las dependencias de modulo wallet
    final IWalletDatasource walletDatasource =
        WalletDatasourceImpl(httpService);
    final IWalletRepository walletRepository =
        WalletRepositoryImpl(walletDatasource);
    final PayPagoMovilUseCase payPagoMovilUseCase =
        PayPagoMovilUseCase(walletRepository);
    final PayZelleUseCase payZelleUseCase = PayZelleUseCase(walletRepository);

    getIt.registerFactory<WalletBloc>(() => WalletBloc(
          payPagoMovilUseCase: payPagoMovilUseCase,
          payZelleUseCase: payZelleUseCase,
        ));
    getIt.registerSingleton<IHttpService>(httpService);
    getIt.registerSingleton<SelectDatasourceBloc>(selectDatasourceBloc);

    //? inicializando las dependencias de modulo tarjeta
    final ICardDatasource cardDatasource =
        CardDatasourceImpl(httpService: httpService);
    final ICardRepository cardRepository =
        CardRepositoryImpl(datasource: cardDatasource);
    getIt.registerFactory<ICardDatasource>(() => cardDatasource);
    getIt.registerFactory<ICardRepository>(() => cardRepository);
    getIt.registerFactory<CardBloc>(
        () => CardBloc(cardRepository: cardRepository));
  }
}
