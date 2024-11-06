import 'package:GoDeli/features/products/application/products/all_products_bloc.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/features/categories/application/categories_bloc.dart';
import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/presentation/widgets/widgets.dart';
import 'package:GoDeli/presentation/screens/Home/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return _HomeScreenView(colors: colors);
  }
}

class _HomeScreenView extends StatelessWidget {
  const _HomeScreenView({
    required this.colors,
  });

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.grid_view_outlined,
          size: 48,
        ),
        title: const Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Deliver to',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Direccion Ejemplo: Guarenas, Miranda',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flex(direction: Axis.horizontal, children: [
                      const Text('Get your ',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w100,
                          )),
                      Text(
                        'groceries',
                        style: TextStyle(
                            fontSize: 40,
                            color: colors.primary,
                            fontWeight: FontWeight.bold),
                      )
                    ]),
                    const Text(
                      'delivered quikly',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w100),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocProvider(
                      create: (_) =>
                          getIt<CategoriesBloc>()..fetchCategoriesPaginated(),
                      child: const CaregoriesCarrusel(),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    BlocProvider(
                      create: (_) =>
                          getIt<AllProductsBloc>()..fetchProductsPaginated(),
                      child: const CardBundleCarrusel(),
                    ),
                  ]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}