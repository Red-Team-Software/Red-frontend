
import 'package:GoDeli/presentation/screens/Cart/cart_screen.dart';
import 'package:GoDeli/presentation/screens/Home/home_screen.dart';
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
    )
  ],
);
