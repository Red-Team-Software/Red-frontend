import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
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
  final List<CategoryProduct> categories;
  final Widget buttonWidget;

  const DetailsView(
      {super.key,
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
      required this.buttonWidget});

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
  final List<CategoryProduct> categories;
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
    final idiom = context.read<LanguagesCubit>().state.selected.language;
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
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
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
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
                      TranslationWidget(
                        message: name,
                        toLanguage: idiom,
                        builder: (translated) => Text(
                          translated,
                          style: textStyles.displayLarge?.copyWith(
                          fontSize: 40
                          ),
                        ),
                      ),
                      if (promotions.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Wrap(
                            spacing: 12,
                            children: promotions
                                .map((promotion) => Chip(
                                      label: Text(
                                        '${promotion.discount * 100}% off',
                                        style:textStyles.displaySmall?.copyWith(
                                          fontSize: 16,
                                          color:colors.secondary,
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
                        // const Text(
                        //   'No promotions available',
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //     color: Colors.black38,
                        //   ),
                        // ),
                      ],
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: 
                        TranslationWidget(
                          message: 'piece',
                          toLanguage: idiom,
                          builder: (translated) => RichText(
                            text: TextSpan(
                              children: [
                                if (promotions.isNotEmpty) ...[
                                  TextSpan(
                                    text:
                                        '$price ${currency == 'usd' ? '\$' : currency}\n',
                                    style: textStyles.displayMedium?.copyWith(
                                      fontSize: 40,
                                      color: Colors.black38,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: colors.primary,
                                      decorationThickness: 2
                                    ),
                                  ),
                                  TextSpan(
                                      text: '${_calculateDiscount(promotions, price).toStringAsFixed(2)}${currency == 'usd' ? '\$' : currency}',
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Theme.of(context).colorScheme.primary,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              '  / $translated\n',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Theme.of(context).brightness ==
                                                          Brightness.light
                                                      ? Colors.black87
                                                      : Colors.white70),
                                        ),
                                      ]),
                                  
                                ] else ...[
                                  TextSpan(
                                    text: price.toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' ${currency == 'usd' ? '\$' : currency} / $translated',
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
                      ),
                      categories.isNotEmpty
                          ? Flex(
                              direction: Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TranslationWidget(
                                  message: 'Categories',
                                  toLanguage: idiom,
                                  builder: (translated) => Text(
                                    translated,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                Wrap(
                                  spacing: 8,
                                  children: categories
                                      .map((category) => Chip(
                                            label: TranslationWidget(
                                                message: category.name,
                                                toLanguage: idiom,
                                                builder: (translated) =>
                                                    Text(translated)),
                                            labelStyle: const TextStyle(
                                              color: Colors.white,
                                            ),
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                          ))
                                      .toList(),
                                ),
                              ],
                            )
                          : const SizedBox(height: 8),
                      TranslationWidget(
                        message: 'Description',
                        toLanguage: idiom,
                        builder: (translated) => Text(
                          translated,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      TranslationWidget(
                        message: description,
                        toLanguage: idiom,
                        builder: (translated) => Text(
                          translated,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      bundleProducts.isNotEmpty
                          ? Flex(
                              direction: Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  TranslationWidget(
                                    message: 'Productos incluidos',
                                    toLanguage: idiom,
                                    builder: (translated) => Text(
                                      translated,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.00,
                                  ),
                                  ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const Divider(),
                                    shrinkWrap: true,
                                    itemCount: bundleProducts.length,
                                    itemBuilder: (context, index) {
                                      final item = bundleProducts[index];
                                      return ListTile(
                                        
                                        title: TranslationWidget(
                                          message: item.name,
                                          toLanguage: idiom,
                                          builder: (translated) => Text(
                                            translated,
                                            style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                              decoration:
                                                  TextDecoration.underline),
                                          ),
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
        acum -= acum * percent.discount;
      }
      return acum;
    }
    return 0;
  }
}
