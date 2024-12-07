import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';
import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_bloc.dart';
import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.watch<CartBloc>();
    final checkoutBloc = context.watch<CheckoutBloc>();
    final colors = Theme.of(context).colorScheme;

    return Container(
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
          Text(
            'Total ${cartBloc.state.totalItems} items in cart',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: cartBloc.state.totalItems == 5 ? Colors.red : Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal',
                style: TextStyle(
                  fontSize: 18, // even smaller font size
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                '\$${cartBloc.state.subtotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18, // even smaller font size
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tax',
                style: TextStyle(
                  fontSize: 18, // even smaller font size
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                '\$${checkoutBloc.state.tax.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18, // even smaller font size
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Shipping',
                style: TextStyle(
                  fontSize: 18, // even smaller font size
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                '\$${checkoutBloc.state.shipping.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18, // even smaller font size
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Divider(color: Colors.grey), // separator line
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '\$${(cartBloc.state.subtotal + checkoutBloc.state.tax + checkoutBloc.state.shipping).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<CheckoutBloc>().add(
                        ProcessPayment(
                          paymentId: "feb39169-bc63-4814-9ac2-f8f98fe0a328",
                          //amount: cartBloc.state.total,
                          currency: 'usd',
                          paymentMethod: "card",
                          stripePaymentMethod: 'pm_card_threeDSecureOptional',
                          address: state.selectedAddress?.location ?? '',
                          bundles: cartBloc.state.bundles
                              .map((bundle) => {
                                    'id': bundle.bundle.id,
                                    'quantity': bundle.quantity
                                  })
                              .toList(),
                          products: cartBloc.state.products
                              .map((product) => {
                                    'id': product.product.id,
                                    'quantity': product.quantity
                                  })
                              .toList(),
                          context: context,
                        ),
                      );
                  context.read<CartBloc>().add(ClearCart());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
