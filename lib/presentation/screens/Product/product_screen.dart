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
        return Stack(fit: StackFit.loose, clipBehavior: Clip.none, children: [
          Image.network(
            state.product.imageUrl[0],
            width: double.infinity,
            fit: BoxFit.cover,
            height: 300,
          ),
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48),
                  ),
                  color: theme.scaffoldBackgroundColor),
              height: double.infinity,
            ),
          ),
          Positioned(
            top: 280,
            child: Container(
              padding: const EdgeInsets.only(right: 32, left: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                        text: state.product.price.toString(),
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                        children: const [
                          TextSpan(
                              text: ' / piece',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.normal))
                        ]),
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
                    state.product.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 16,),

                  ElevatedButton(
                    onPressed: () { },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary, // Color de fondo del botón
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric( vertical: 16, horizontal: 52), 
                    ),
                    child: const Center(
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]);
      })),
    );
  }
}
