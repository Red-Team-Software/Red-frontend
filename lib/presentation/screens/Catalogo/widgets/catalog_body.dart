import 'dart:ui';

import 'package:GoDeli/features/categories/application/all-categories/categories_bloc.dart';
import 'package:GoDeli/features/catalog/bloc/catalog_bloc.dart';
import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/presentation/widgets/item/custom_item_product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogBody extends StatelessWidget {
  const CatalogBody({super.key});

  @override
  Widget build(BuildContext context) {
    final categories =
        List<Category>.from(context.watch<CategoriesBloc>().state.categories);

    return BlocConsumer<CatalogBloc, CatalogState>(
      listener: (context, state) {
        if (state.status == CatalogStatus.error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Error')));
        }
      },
      builder: (context, state) {
        if (state.status == CatalogStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

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
                              selected: state.categorySelected
                                  .any((element) => element == category.id),
                              onSelected: (selected) {
                                context
                                    .read<CatalogBloc>()
                                    .add(CategorySet(category.id));
                              },
                              label: Text(category.name),
                              elevation: 5.0,
                              labelStyle: TextStyle(
                                color: state.categorySelected.any(
                                        (element) => element == category.id)
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
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.00),
                height: 80,
                child: Row(children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: context
                          .watch<CatalogBloc>()
                          .state
                          .popular
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      backgroundColor: context
                              .watch<CatalogBloc>()
                              .state
                              .popular
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                    iconAlignment: IconAlignment.end,
                    onPressed: () =>
                        context.read<CatalogBloc>()..add(const PopularSet()),
                    label: const Text('Popular'),
                    icon: const Icon(Icons.star),
                  ),
                  const SizedBox(width: 12),
                  Text('Discount: ${context.watch<CatalogBloc>().state.discount}%'),
                  Expanded(
                    child: Slider(
                      value: context.read<CatalogBloc>().state.discount,
                      onChanged: (value) {
                        // Update the slider value in the state
                        context.read<CatalogBloc>().add(DiscountSet(value));
                      },
                      onChangeEnd: (value) {
                        // Make the request and change the state when the slider is released
                        context.read<CatalogBloc>().add(DiscountSet(value));
                      },
                    ),
                  ),
                ]),
              ),
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
            state.bundles.isNotEmpty
                ? SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.bundles[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _CustomItemGrid(
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
                  )
                : const SliverToBoxAdapter(
                    child: Center(
                      child: Text('No bundles available'),
                    ),
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
            state.products.isNotEmpty
                ? SliverToBoxAdapter(
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
                  )
                : const SliverToBoxAdapter(
                    child: Center(
                      child: Text('No products available'),
                    ),
                  ),
          ],
        );
      },
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

class _CustomItemGrid extends StatelessWidget {
  final String id;
  final String name;
  final List<String> imageUrl;
  final double price;
  final String redirect;

  const _CustomItemGrid(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.redirect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.push('$redirect/$id');
        },
        child: Material(
          elevation: 8.0,
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              SizedBox(
                height: 200, // Ajusta la altura según tus necesidades
                width: double.infinity,
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl[0],
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.image_not_supported,
                        size: 64,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
