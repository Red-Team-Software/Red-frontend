import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/shipping_address_section.dart';
import 'widgets/delivery_time_section.dart';
import 'widgets/payment_method_section.dart';
import 'widgets/order_summary_section.dart';

class CheckoutScreen extends StatelessWidget {
  static const String name = 'checkout_screen';

  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
          cartItemCount: 3), // Ejemplo de 3 artículos en el carrito
      body: SingleChildScrollView(
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
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int cartItemCount;

  const CustomAppBar({super.key, required this.cartItemCount});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios),
      ),
      title: const Text(
        'Checkout',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      actions: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              onPressed: () {
                context.push("/cart");
              },
              icon: Icon(
                Icons.shopping_bag,
                size: 30, // Tamaño más grande
                color: colors.primary, // Color primario
              ),
            ),
            if (cartItemCount > 0)
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
                    '$cartItemCount',
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
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
