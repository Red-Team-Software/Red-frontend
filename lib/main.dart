import 'package:GoDeli/features/bundles/application/bundles/all_bundles_bloc.dart';
import 'package:GoDeli/features/auth/application/bloc/auth_bloc.dart';
import 'package:GoDeli/features/card/aplication/Blocs/card_bloc.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/config/constants/enviroments.dart';
import 'package:GoDeli/features/common/application/bloc/select_datasource_bloc_bloc.dart';
import 'package:GoDeli/features/orders/aplication/Bloc/orders_bloc.dart';
import 'package:GoDeli/features/orders/aplication/Bloc/orders_event.dart';
import 'package:GoDeli/features/categories/application/all-categories/categories_bloc.dart';
import 'package:GoDeli/features/user/application/bloc/user_bloc.dart';
import 'package:GoDeli/features/products/application/products/all_products_bloc.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/presentation/core/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:GoDeli/presentation/core/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize environment variables
  await Firebase.initializeApp();

  // Register Blocs in service locator
  await Injector().setUp();

  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SelectDatasourceBloc>()),
        BlocProvider(create: (context) => getIt<CartBloc>()),
        BlocProvider(
          create: (context) => LanguagesCubit(),
        ),
        BlocProvider(
          create: (context) =>
              getIt<AllProductsBloc>()..fetchProductsPaginated(),
        ),
        BlocProvider(
          create: (context) => getIt<AllBundlesBloc>()..fetchBundlesPaginated(),
        ),
        BlocProvider(
          create: (context) =>
              getIt<CategoriesBloc>()..fetchCategoriesPaginated(),
        ),
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<UserBloc>()),
        BlocProvider(
            create: (context) =>
                getIt<OrdersBloc>()..add(const OrdersLoaded())),
        BlocProvider(create: (context) => getIt<CardBloc>()),
      ],
      child: const GoDeli(),
    );
  }
}

class GoDeli extends StatelessWidget {
  const GoDeli({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Red Team',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: context.watch<SelectDatasourceBloc>().state.isRed == true ?  RedAppTheme().getTheme() : BlueAppTheme().getTheme(), 
    );
  }
}
