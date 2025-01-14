import 'dart:ui';

import 'package:GoDeli/features/categories/application/all-categories/categories_bloc.dart';
import 'package:GoDeli/features/catalog/bloc/catalog_bloc.dart';
import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/presentation/screens/Catalogo/widgets/catalog_filter.dart';
import 'package:GoDeli/presentation/widgets/item/custom_item_grid.dart';
import 'package:GoDeli/presentation/widgets/item/custom_item_product.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogBody extends StatelessWidget {
  const CatalogBody({super.key});

  @override
  Widget build(BuildContext context) {
    final categories =
        List<Category>.from(context.watch<CategoriesBloc>().state.categories);

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            minHeight: 80.0,
            maxHeight: 90.0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    color: Colors.white.withOpacity(0.5),
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ChoiceChip(
                          showCheckmark: false,
                          selectedColor: Theme.of(context).primaryColor,
                          disabledColor: Colors.grey[200],
                          selected: context.watch<CatalogBloc>()
                              .state.categorySelected.any((element) => element == category.name),
                          onSelected: (selected) {
                            context
                                .read<CatalogBloc>()
                                .add(CategorySet(category.name));
                          },
                          label: Text(category.name),
                          elevation: 5.0,
                          labelStyle: TextStyle(
                            color: context
                                    .read<CatalogBloc>()
                                    .state
                                    .categorySelected
                                    .any((element) => element == category.name)
                                ? Colors.white
                                : Colors.black,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: FilterCatalog(),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12.00),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Bundles',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ),
        ),
        BlocBuilder<CatalogBloc, CatalogState>(
          builder: (context, state) {
            if (state.status == CatalogStatus.loading) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state.status == CatalogStatus.error) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text('Error loading bundles'),
                ),
              );
            }

            if (state.bundles.isEmpty) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text('No bundles available'),
                ),
              );
            }


            return SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = state.bundles[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomItemGrid(
                        id: item.id,
                        name: item.name,
                        imageUrl: item.imageUrl,
                        price: item.price,
                        redirect: '/bundle',
                      ),
                    );
                  },
                  childCount: state.bundles.length,
                ),
              ),
            );
          },
        ),
        SliverPadding(
          padding:
              const EdgeInsets.symmetric(vertical: 8.00, horizontal: 12.00),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Products',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ),
        ),
        BlocBuilder<CatalogBloc, CatalogState>(
          builder: (context, state) {

            if (state.status == CatalogStatus.loading) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state.status == CatalogStatus.error) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text('Error loading products'),
                ),
              );
            }

            if (state.products.isEmpty) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text('No products available'),
                ),
              );
            }

            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: SizedBox(
                  height: 200, // Ajusta la altura según tus necesidades
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 8,
                      childAspectRatio:
                          0.28, // Ajusta el aspecto para que ocupe todo el ancho
                    ),
                    itemCount: state.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      Product currentProduct = state.products[index];
                      return SizedBox(
                        width: MediaQuery.of(context)
                            .size
                            .width, // Ocupa todo el ancho de la pantalla
                        child: CustomItemProduct(
                          theme: Theme.of(context),
                          current: currentProduct,
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
