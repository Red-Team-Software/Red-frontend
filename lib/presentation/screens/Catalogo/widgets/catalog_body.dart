import 'dart:ui';

import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/categories/application/all-categories/categories_bloc.dart';
import 'package:GoDeli/features/catalog/bloc/catalog_bloc.dart';
import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/Catalogo/widgets/catalog_filter.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:GoDeli/presentation/widgets/item/custom_item_grid.dart';
import 'package:GoDeli/presentation/widgets/item/custom_item_product.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogBody extends StatefulWidget {
  const CatalogBody({super.key});

  @override
  State<CatalogBody> createState() => _CatalogBodyState();
}

class _CatalogBodyState extends State<CatalogBody> {
  bool showProducts = true;

  // Método para construir el contenido de Bundles
  Widget _buildBundles(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        if (state.status == CatalogStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == CatalogStatus.error) {
          return const Center(child: Text('Error loading bundles'));
        }
        if (state.bundles.isEmpty) {
          return const Center(child: Text('No bundles available'));
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
            ),
            itemCount: state.bundles.length,
            itemBuilder: (context, index) {
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
          ),
        );
      },
    );
  }

  // Método para construir el contenido de Products
  Widget _buildProducts(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        if (state.status == CatalogStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == CatalogStatus.error) {
          return const Center(child: Text('Error loading products'));
        }
        if (state.products.isEmpty) {
          return const Center(child: Text('No products available'));
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
            ),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomItemProduct(current: product, theme: theme),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories =
        List<Category>.from(context.watch<CategoriesBloc>().state.categories);
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 2, // Dos pestañas: Bundles y Products
      child: CustomScrollView(
        slivers: [
          // CategoriesSliverCatalog(categories: categories),

          // Botón de Filtros
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list, color: colors.primary),
                    onPressed: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return _FilterModal(categories: categories);
                        },
                      );
                      context.read<CatalogBloc>().fetchItems();
                    },
                  ),
                ],
              ),
            ),
          ),

          // const SliverToBoxAdapter(
          //   child: DiscountPopularPriceFilterCatalog(),
          // ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: colors.primary,
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Bundles',
                            style: TextStyle(
                              fontSize: textStyle.displaySmall!.fontSize,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Products',
                            style: TextStyle(
                              fontSize: textStyle.displaySmall!.fontSize,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // TabBarView para alternar entre los dos contenidos
          SliverFillRemaining(
            child: TabBarView(
              children: [
                _buildBundles(context), // Contenido de Bundles
                _buildProducts(context), // Contenido de Products
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterModal extends StatelessWidget {
  final List<Category> categories;

  const _FilterModal({required this.categories});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => getIt<CatalogBloc>(),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          constraints: const BoxConstraints(maxHeight: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Filters',
                style: textStyle.displayMedium,
              ),
              const Divider(),
              _CategoriesList(categories: categories),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Apply Filters'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesSliverCatalog extends StatelessWidget {
  const CategoriesSliverCatalog({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return SliverPersistentHeader(
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
                      selected: context
                          .watch<CatalogBloc>()
                          .state
                          .categorySelected
                          .any((element) => element == category.name),
                      onSelected: (selected) {
                        context
                            .read<CatalogBloc>()
                            .add(CategorySet(category.name));
                      },
                      label: TranslationWidget(
                        message: category.name,
                        toLanguage: context
                            .watch<LanguagesCubit>()
                            .state
                            .selected
                            .language,
                        builder: (translated) => Text(translated),
                      ),
                      elevation: 5.0,
                      labelStyle: textStyle.bodyLarge?.copyWith(
                        color: context
                                .watch<CatalogBloc>()
                                .state
                                .categorySelected
                                .any((element) => element == category.name)
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoriesList extends StatelessWidget {
  const _CategoriesList({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return SizedBox(
      height: 80, // Altura fija para que sea consistente
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ChoiceChip(
            showCheckmark: false,
            selectedColor: Theme.of(context).primaryColor,
            disabledColor: Colors.grey[200],
            selected: context
                .watch<CatalogBloc>()
                .state
                .categorySelected
                .any((element) => element == category.name),
            onSelected: (selected) {
              context.read<CatalogBloc>().add(CategorySet(category.name));
            },
            label: TranslationWidget(
              message: category.name,
              toLanguage:
                  context.watch<LanguagesCubit>().state.selected.language,
              builder: (translated) => Text(translated),
            ),
            elevation: 5.0,
            labelStyle: textStyle.bodyLarge?.copyWith(
              color: context
                      .watch<CatalogBloc>()
                      .state
                      .categorySelected
                      .any((element) => element == category.name)
                  ? Colors.white
                  : Theme.of(context).primaryColor,
            ),
          );
        },
      ),
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
