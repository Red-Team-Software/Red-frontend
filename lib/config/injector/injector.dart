import 'package:GoDeli/features/cart/application/cart/cart_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class Injector {
  void setupInjection() {
    getIt.registerSingleton(CartBloc());
  }
}
