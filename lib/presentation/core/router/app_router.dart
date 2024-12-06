import 'package:GoDeli/features/order/aplication/Bloc/order_bloc.dart';
import 'package:GoDeli/features/order/domain/order.dart';
import 'package:GoDeli/presentation/core/router/index.dart';
import 'package:GoDeli/presentation/screens/Catalogo/view/catalog_screen.dart';
import 'package:GoDeli/presentation/screens/Checkout/checkout_screen.dart';
import 'package:GoDeli/presentation/screens/Order/order_screen.dart';
import 'package:GoDeli/presentation/screens/auth/auth_screen.dart';
import 'package:GoDeli/presentation/screens/Search/search.dart';
import 'package:GoDeli/presentation/screens/Bundle/bundle.dart';
import 'package:GoDeli/presentation/screens/profile/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../screens/screen.dart';

final appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/auth',
  routes: [
    GoRoute(
      path: '/',
      name: IndexPage.name,
      builder: (context, state) => const IndexPage(),
    ),
    GoRoute(
      path: '/search',
      name: SearchScreen.name,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/cart',
      name: CartScreen.name,
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/profile',
      name: ProfileScreen.name,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/auth',
      name: AuthScreen.name,
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/categories',
      name: CategoriesScreen.name,
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: '/catalog',
      name: CatalogScreen.name,
      builder: (context, state) => const CatalogScreen(),
    ),
    GoRoute(
      path: '/product/:idProduct',
      name: ProductScreen.name,
      builder: (context, state) =>
          ProductScreen(idProduct: state.pathParameters['idProduct'] ?? ''),
    ),
    GoRoute(
      path: '/bundle/:idBundle',
      name: BundleScreen.name,
      builder: (context, state) =>
          BundleScreen(idBundle: state.pathParameters['idBundle'] ?? ''),
    ),
    GoRoute(
      path: "/checkout",
      name: CheckoutScreen.name,
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: "/order/:idOrder",
      name: OrderSummaryScreen.name,
      builder: (context, state) {
        final order = state.extra
            as Order; // Asegúrate de pasar la orden desde el `CheckoutBloc`
        return BlocProvider(
          create: (_) {
            final orderBloc = OrderBloc();
            orderBloc.add(LoadOrder(order: order)); // Disparar el evento aquí
            return orderBloc;
          },
          child: OrderSummaryScreen(
            idOrder: state.pathParameters['idOrder'] ?? '',
          ),
        );
      },
    ),
  ],
);
