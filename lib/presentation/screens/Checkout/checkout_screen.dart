import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_bloc.dart';
import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_event.dart';
import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_state.dart';
import 'package:GoDeli/features/order/domain/repositories/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/shipping_address_section.dart';
import 'widgets/delivery_time_section.dart';
import 'widgets/payment_method_section.dart';
import 'widgets/order_summary_section.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  static const String name = 'checkout_screen';

  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutBloc(
        cartBloc: context.read<CartBloc>(),
        orderRepository: getIt<IOrderRepository>(),
        onOrderCreated: (order) {
          GoRouter.of(context).push(
            '/order/${order.id}',
            extra: order, // Pasar la orden completa
          );
        },
      )..add(LoadCheckoutData()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Checkout',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.push("/cart");
                      },
                      icon: Icon(
                        Icons.shopping_bag,
                        size: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    if (state.cartItemsCount > 0)
                      Positioned(
                        right: 0,
                        top: -2,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Text(
                            '${state.cartItemsCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state.isProcessing) {
              return const Center(child: CircularProgressIndicator());
            }
            return const SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShippingAddressSection(),
                  SizedBox(height: 16),
                  DeliveryTimeSection(),
                  SizedBox(height: 16),
                  PaymentMethodSection(),
                  SizedBox(height: 16),
                  OrderSummarySection(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
