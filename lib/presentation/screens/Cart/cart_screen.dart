import 'package:GoDeli/features/cart/application/cart/cart_bloc.dart';
import 'package:GoDeli/features/cart/domain/cart.dart';
import 'package:GoDeli/presentation/widgets/cart/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {

  static const String name = 'cart_screen';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=> context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Cart',
          style: TextStyle(
            fontSize: 30, 
            fontWeight: FontWeight.bold
          ),
        ),
        actions: <Widget>[
          Text(
            '${context.watch<CartBloc>().state.totalItems} items', 
            style: TextStyle(
              color: colors.primary,
              fontSize: 18, 
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(width: 8,)
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

    final cart = cartBloc.state.cart;
   
   
    final colors = Theme.of(context).colorScheme;



    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //? Lista de productos
        Expanded(
            child: ListView.builder(
                itemCount: cartBloc.state.totalItems,
                itemBuilder: (context, index) {
                  final product = cart.products[index];
                  return ProductWidget(product: product);
                })),
        Container(
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
          child: TextButton(
            onPressed: () {
              //TODO: Aquí iría la lógica para aplicar un cupón de descuento


              //! Ejemplo de cómo agregar un producto al carrito
              final prod = Product(
                id: '4',
                name: 'producto4',
                price: 10,
                quantity: 1,
                description: 'descripcion1'
              );

              cartBloc.add(AddProduct(prod));
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
              ]
            ),
          ),
        ),
        //? Resumen de la compra
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Subtotal',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 4, 4, 4),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '\$${cartBloc.state.subtotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
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
                  backgroundColor: colors.primary, // Color de fondo del botón
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
                )
              )
            ],
          ),
        )
      ],
    );
  }
}
