import 'dart:ui';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:GoDeli/config/injector/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/features/products/application/productDetails/product_details_bloc.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  static const String name = 'details_product_screen';

  final String idProduct;
  const ProductScreen({super.key, required this.idProduct});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductDetailsBloc>()..getProductById(idProduct),
      child: const _ProductView(),
    );
  }
}

class _ProductView extends StatelessWidget {
  const _ProductView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(body:
          BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
              builder: (context, state) {
        if (state.status == ProductDetailsStatus.loading ||
            state.status == ProductDetailsStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == ProductDetailsStatus.error) {
          return const Center(
            child: Text(
              'Ups! Something wrong happen',
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        return Stack(children: [
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Image.network(
              state.product.imageUrl[0],
              fit: BoxFit.cover,
            ),
          ),
          _buttonArrow(context),
          _scrollableDetails(state.product, theme)
        ]);
      })),
    );
  }

  Widget _buttonArrow(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop();
      },
      child: Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(16),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Center(
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black45,
                ),
              ),
            ),
          )),
    );
  }

  Widget _scrollableDetails(Product product, ThemeData theme) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.68,
      maxChildSize: 0.75,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          text: product.price.toString(),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: '${product.currency} / piece',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      // TODO: hacer los tags estos
                      const Text(
                        'TODO: tags de categorias',
                        style: TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        product.description,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _showModal(context, theme, product);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 24),
                ),
                child: const Center(
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> _showModal(BuildContext context, ThemeData theme, Product product) => showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.only(top: 32, bottom: 16, left: 16, right: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Price: ${product.price} ${product.currency}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                    
                    CustomCartActionButton()
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 24),
                ),
                child: const Center(
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ],
            ),
          );
        },
      );
}

