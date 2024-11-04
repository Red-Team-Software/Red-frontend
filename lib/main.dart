import 'package:flutter/material.dart';
import 'package:GoDeli/presentation/core/router/app_router.dart';
import 'package:GoDeli/presentation/core/theme/theme.dart';

void main() {
  runApp(const GoDeli());
}

class GoDeli extends StatelessWidget {
  const GoDeli({super.key});

  // This widget is the root of your application.
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
