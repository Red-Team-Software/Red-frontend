import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/Cart/widgets/custom_cart_bundle.dart';
import 'package:GoDeli/presentation/screens/Cart/widgets/custom_cart_product.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  static const String name = 'cart_screen';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return _CartScreen(colors: colors);
  }
}

class _CartScreen extends StatelessWidget {
  const _CartScreen({
    required this.colors,
  });

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    final totalItems = context.watch<CartBloc>().state.totalItems;
    final textStyles = Theme.of(context).textTheme;
    final language =  context.watch<LanguagesCubit>().state.selected.language;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: 
        TranslationWidget(
          message: 'Cart',
          toLanguage: language,
          builder: (translated) => Text(
            translated,
            style: textStyles.displayLarge
          ), 
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 12, right: 16),
            child: Text(
              '$totalItems ${totalItems == 1 ? 'item' : 'items'}',
              style: textStyles.displaySmall?.copyWith(color: colors.primary),
            ),
          ),
          const SizedBox(
            width: 8,
          )
        ],
      ),
      body: _CartView(),
    );
  }
}

class _CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartBloc = context.watch<CartBloc>();

    final cart = cartBloc.state;

    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final language =  context.watch<LanguagesCubit>().state.selected.language;


    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //? Lista de productos
          Expanded(child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (cartBloc.state.totalItems == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 100,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      TranslationWidget(
                        message: 'Your cart is empty',
                        toLanguage: language,
                        builder: (translated) => Text(
                            translated,
                            style: textStyles.displayMedium?.copyWith(
                              color: Colors.grey[400],
                            ),
                        ), 
                      ),
                    ],
                  ),
                );
              } else {
                return ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: [
                    if (cartBloc.state.totalProducts > 0) ...[
                      ...List.generate(
                        cartBloc.state.totalProducts,
                        (index) {
                          final product = cartBloc.state.products[index];
                          return Column(
                            children: [
                              ProductWidget(product: product),
                              Divider(
                                
                                color: Colors.grey[300],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                    if (cartBloc.state.totalBundles > 0) ...[
                      ...List.generate(
                        cartBloc.state.totalBundles,
                        (index) {
                          final bundle = cartBloc.state.bundles[index];
                          return Column(
                            children: [
                              BundleWidget(bundle: bundle),
                              Divider(
                                color: Colors.grey[300],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ],
                );
              }
            },
          )),
          //? Resumen de la compra
          if (cartBloc.state.totalItems > 0)
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8.0),
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Total
                      TranslationWidget(
                        message: 'Subtotal',
                        toLanguage: language,
                        builder: (translated) => Text(
                            translated,
                            style: textStyles.displayLarge
                        ), 
                      ),
                      Text(
                        '\$${cartBloc.state.total.toStringAsFixed(2)}',
                        style: textStyles.displayLarge
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                      onPressed: () {
                        context.push("/checkout");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            colors.primary, // Color de fondo del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: TranslationWidget(
                        message: 'Proceed to checkout',
                        toLanguage: language,
                        builder: (translated) => Text(
                            translated,
                            style: textStyles.displayMedium?.copyWith(
                            color: Colors.white
                          )
                        ), 
                      )
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
