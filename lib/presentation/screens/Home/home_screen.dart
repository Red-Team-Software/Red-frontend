import 'package:flutter/material.dart';
import 'package:GoDeli/features/products/application/products/all_products_bloc.dart';
import 'package:GoDeli/features/products/domain/product.dart';
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
    return BlocProvider(
      create: (_) => getIt<AllProductsBloc>()..fetchProductsPaginated(),
      child: const _HomeScreenView(),
    );
  }
}

class _HomeScreenView extends StatelessWidget {
  const _HomeScreenView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
      body:CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: 24, left: 8, right: 8),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'Get your',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w100,
                              color: theme.brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            children:  [
                              TextSpan(
                                  text: ' groceries',
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(
                                text: ' delivered quikly',
                              ),
                            ]),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      BlocProvider(
                        create: (_) =>
                            getIt<CategoriesBloc>()..fetchCategoriesPaginated(),
                        child: const CaregoriesCarrusel(),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const CardBundleCarrusel(),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Popular',
                            style: TextStyle(
                                color: theme.brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 32),
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: Text(
                                'view all',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w700),
                              )),
                        ],
                      )
                    ],
                  ),
                ]),
              ),
            ),
            BlocBuilder<AllProductsBloc,AllProductsState>(
              builder: (context, state) {
                if (state.status == ProductsStatus.loading && state.products.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state.status == ProductsStatus.error) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text('Algo inesperado paso',
                          style: TextStyle(color: Colors.red)),
                    ),
                  );
                }
                return SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                Product current = state.products[index];
                                return CustomItemProduct(current: current, theme: theme);
                              },
                              childCount: state.products.length,
                            ),
                          ),
                        );
              },
            ),
          ],
        ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
