import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/presentation/widgets/card/images_carrusel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets.dart';

class DetailsView extends StatelessWidget {
  final List<String> images;
  final String name;
  final String description;
  final double price;
  final String currency;
  final double? weigth;
  final String? measurement;
  final String? expirationDate;
  final int? inStock;
  final List<Promotion> promotions;
  final List<BundleProduct> bundleProducts;
  final List<Category> categories;
  final Widget buttonWidget;

  const DetailsView({super.key, 
  required this.images, 
  required this.name, 
  required this.description, 
  required this.price, 
  required this.currency, 
  this.weigth, 
  this.measurement, 
  this.expirationDate, 
  this.inStock, 
  this.promotions = const [], 
  this.bundleProducts = const [], 
  this.categories = const [], 
  required this.buttonWidget
});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Stack(
            children: [
              ImagesCarrusel(images: images),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black54,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        CustomButtonArrowImage(context: context),
        _ScrollableDetails(
          name: name,
          description: description,
          price: price,
          currency: currency,
          weigth: weigth,
          measurement: measurement,
          expirationDate: expirationDate,
          inStock: inStock,
          promotions: promotions,
          bundleProducts: bundleProducts,
          categories: categories,
          buttonWidget: buttonWidget,
        ),
      ],
    );
  }

  
}


class _ScrollableDetails extends StatelessWidget {
  
  final String name;
  final String description;
  final double price;
  final String currency;
  final double? weigth;
  final String? measurement;
  final String? expirationDate;
  final int? inStock;
  final List<Promotion> promotions;
  final List<BundleProduct> bundleProducts;
  final List<Category> categories;
  final Widget buttonWidget;


  const _ScrollableDetails({
    required this.name, 
    required this.description, 
    required this.price, 
    required this.currency, 
    required this.buttonWidget,
    this.weigth, 
    this.measurement, 
    this.expirationDate, 
    this.inStock, 
    this.promotions = const [], 
    this.bundleProducts = const [], 
    this.categories = const [],
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.68,
      maxChildSize: 0.75,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 40,
                        ),
                      ),
                      if (promotions.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Wrap(
                            spacing: 8,
                            children: promotions
                                .map((promotion) => Chip(
                                      label: Text(
                                        '${promotion.percentage * 100}% off',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                    ))
                                .toList(),
                          ),
                        ),
                      ] else ...[
                        const SizedBox(height: 8),
                        const Text(
                          'No promotions available',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              if (promotions.isNotEmpty) ...[
                                TextSpan(
                                    text: _calculateDiscount(promotions, price)
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            ' ${currency == 'usd' ? '\$' : currency} / piece\n',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black87
                                                    : Colors.white70),
                                      ),
                                    ]),
                                TextSpan(
                                  text:
                                      '$price ${currency == 'usd' ? '\$' : currency}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                    decorationThickness: 2,
                                  ),
                                ),
                              ] else ...[
                                TextSpan(
                                  text: price.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' ${currency == 'usd' ? '\$' : currency} / piece',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      categories.isNotEmpty
                          ? Flex(
                              direction: Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Categories',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                Wrap(
                                  spacing: 8,
                                  children: categories
                                      .map((category) =>
                                          Chip(label: Text(category.name)))
                                      .toList(),
                                ),
                              ],
                            )
                          : const SizedBox(height: 8),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 12.00,
                      ),
                      bundleProducts.isNotEmpty
                          ? Flex(
                              direction: Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  const Text(
                                    'Products included',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.00,
                                  ),
                                  ListView.separated(
                                    separatorBuilder: (context, index) => const Divider(),
                                    shrinkWrap: true,
                                    itemCount: bundleProducts.length,
                                    itemBuilder: (context, index) {
                                      final item = bundleProducts[index];
                                      return ListTile(
                                        title: Text(
                                          item.name,
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(
                                              Icons.arrow_forward_ios),
                                          onPressed: () => GoRouter.of(context)
                                              .push('/product/${item.id}'),
                                        ),
                                      );
                                    },
                                  ),
                                ])
                          : Container()
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              buttonWidget
            ],
          ),
        );
      },
    );
  }


  double _calculateDiscount(List<Promotion> promotions, double price) {
    if (promotions.isNotEmpty) {
      late double acum = price;
      for (final percent in promotions) {
        acum -= acum * percent.percentage;
      }
      return acum;
    }
    return 0;
  }
}