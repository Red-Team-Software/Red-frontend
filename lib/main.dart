import 'package:GoDeli/features/cart/application/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/presentation/core/router/app_router.dart';
import 'package:GoDeli/presentation/core/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/config/injector/injector.dart';

void main() {

  Injector().setupInjection();

  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<CartBloc>()),
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
      theme: AppTheme().getTheme(),
    );
  }
}
