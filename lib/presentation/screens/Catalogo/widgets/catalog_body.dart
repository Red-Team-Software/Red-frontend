import 'dart:ui';

import 'package:GoDeli/features/bundles/application/bundles/all_bundles_bloc.dart';
import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/categories/application/all-categories/categories_bloc.dart';
import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/products/application/products/all_products_bloc.dart';
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
    final bundles = context.watch<AllBundlesBloc>().state.bundles;
    final products = context.watch<AllProductsBloc>().state.products;

    // Check if "All" category already exists
    if (!categories.any((category) => category.name == 'All')) {
      categories.insert(0, Category(id: '1', name: 'All', icon: ''));
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
                      separatorBuilder: (context, index) => const SizedBox(width: 8),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Chip(
                          label: Text(category.name),
                          elevation: 5.0,
                          backgroundColor: index == 0
                              ? Theme.of(context).primaryColor
                              : Colors.grey[200],
                          labelStyle: TextStyle(
                            color: index == 0 ? Colors.white : Colors.black,
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
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = bundles[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _CustomItemGrid(current: item),
                );
              },
              childCount: bundles.length,
            ),
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final item = products[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 4.00, horizontal: 8.00),
                child:
                    CustomItemProduct(current: item, theme: Theme.of(context)),
              );
            },
            childCount: products.length,
          ),
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

class _CustomItemGrid extends StatelessWidget {
  final Bundle current;
  const _CustomItemGrid({required this.current});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.push('/bundle/${current.id}');
        },
    child: Material(
      elevation: 8.0,
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              current.imageUrl.isNotEmpty ? current.imageUrl[0] : '',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                    size: 40,
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.all(4.0),
              child: Text(
                current.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
