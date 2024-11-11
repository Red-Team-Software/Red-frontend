import 'package:GoDeli/presentation/screens/auth/view/auth_page.dart';

import 'package:go_router/go_router.dart';
import '../../screens/screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/cart',
      name: CartScreen.name,
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/auth',
      name: AuthPage.name,
      routes: const [],
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: '/search',
      name: SearchScreen.name,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/categories',
      name: CategoriesScreen.name,
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
        path: '/product/:idProduct',
        name: ProductScreen.name,
        builder: (context, state) =>
            ProductScreen(idProduct: state.pathParameters['idProduct'] ?? ''),
      ),
  ],
);
