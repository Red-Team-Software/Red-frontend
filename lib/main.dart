import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/config/Fcm/Fcm.dart';
import 'package:GoDeli/config/constants/enviroments.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/presentation/core/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:GoDeli/presentation/core/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize environment variables
  await Environment.initEnvironment();
  await Firebase.initializeApp();

  configureFCM();

  // Register Blocs in service locator
  Injector().setUp();

  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<CartBloc>() ),
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
