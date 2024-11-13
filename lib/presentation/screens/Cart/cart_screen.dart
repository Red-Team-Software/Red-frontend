import 'package:GoDeli/features/cart/application/cart/cart_bloc.dart';
import 'package:GoDeli/presentation/screens/Cart/widgets/custom_cart_bundle.dart';
import 'package:GoDeli/presentation/screens/Cart/widgets/custom_cart_product.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Cart',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Text(
            '${context.watch<CartBloc>().state.totalItems} items',
            style: TextStyle(
                color: colors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold),
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

    return Column(
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
                    Text(
                      'Your cart is empty',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
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
                        return ProductWidget(product: product);
                      },
                    ),
                  ],
                  if (cartBloc.state.totalBundles > 0) ...[
                    ...List.generate(
                      cartBloc.state.totalBundles,
                      (index) {
                        final bundle = cartBloc.state.bundles[index];
                        return BundleWidget(bundle: bundle);
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
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
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
                TextButton(
                  onPressed: () {
                    //TODO: Aquí iría la lógica para aplicar un cupón de descuento
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_offer, color: colors.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Apply coupon',
                          style: TextStyle(
                            color: colors.primary,
                            fontSize: 16,
                          ),
                        ),
                      ]),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Subtotal',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 4, 4, 4),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${cartBloc.state.subtotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      '%${cart.discount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Divider(height: 24, color: Colors.grey[400]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Total
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '\$${cartBloc.state.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () {
                      cartBloc.add(ClearCart());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          colors.primary, // Color de fondo del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text(
                      'Proceed to checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
          )
      ],
    );
  }
}
