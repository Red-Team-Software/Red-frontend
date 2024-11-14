import 'package:GoDeli/presentation/core/router/index.dart';
import 'package:GoDeli/presentation/screens/Cart/cart_screen.dart';
import 'package:GoDeli/presentation/screens/Checkout/checkout_screen.dart';
import 'package:GoDeli/presentation/screens/Home/home_screen.dart';
import 'package:GoDeli/presentation/screens/Order/order_screen.dart';
import 'package:GoDeli/presentation/screens/auth/view/auth_page.dart';
import 'package:GoDeli/presentation/screens/profile/view/profile_page.dart';
import 'package:GoDeli/presentation/screens/search/view/search_page.dart';
import 'package:go_router/go_router.dart';
import '../../screens/screen.dart';

final appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: IndexPage.name,
      builder: (context, state) => const IndexPage(),
    ),
    GoRoute(
      path: '/search',
      name: SearchPage.name,
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      path: '/cart',
      name: CartScreen.name,
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/profile',
      name: ProfilePage.name,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/auth',
      name: AuthPage.name,
      builder: (context, state) => const AuthPage(),
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
    GoRoute(
      path: "/checkout",
      name: CheckoutScreen.name,
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: "/order/:idOrder",
      name: OrderSummaryScreen.name,
      builder: (context, state) =>
          OrderSummaryScreen(idOrder: state.pathParameters['idProduct'] ?? ''),
    )
  ],
);
