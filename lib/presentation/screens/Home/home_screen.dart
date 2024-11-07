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
      body: BlocBuilder<AllProductsBloc, AllProductsState>(
        builder: (context, state) {
          if (state.status == ProductsStatus.loading && state.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == ProductsStatus.error) {
            return const Center(child: Text('Algo inesperado paso', style: TextStyle(color: Colors.red)),);
          }

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top: 32, left: 8, right: 8),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              const Text('Get your ', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w100,)),
                              Text('groceries',style: TextStyle(fontSize: 40, color: theme.colorScheme.primary, fontWeight: FontWeight.bold),)
                            ]),
                          const Text('delivered quikly', style:TextStyle(fontSize: 40, fontWeight: FontWeight.w100),),
                          const SizedBox(height: 16,),

                          BlocProvider(
                            create: (_) =>
                                getIt<CategoriesBloc>()..fetchCategoriesPaginated(),
                            child: const CaregoriesCarrusel(),
                          ),
                          const SizedBox(height: 24,),

                          const CardBundleCarrusel(),
                          const SizedBox(height: 24,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Popular', 
                                style: TextStyle(color: theme.brightness == Brightness.dark?Colors.white:Colors.black, fontWeight: FontWeight.bold, fontSize: 32),)
                            ],
                          )
                        ],),
                    ]),
              ),),
              SliverPadding(
                padding: const EdgeInsets.only(left: 16.00, right: 16.00),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      Product current = state.products[index];
                      return CustomItemProduct(current: current, theme: theme);
                    },
                    childCount: state.products.length,
                  ),
                ),
              ),
            ],
          );
        } 
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
