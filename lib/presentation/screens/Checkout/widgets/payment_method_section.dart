import 'package:GoDeli/features/payment-method/domain/payment-method.dart' as goDeli;
import 'package:GoDeli/features/checkout/aplication/checkout/checkout_bloc.dart';
import 'package:GoDeli/features/checkout/aplication/checkout/checkout_event.dart';
import 'package:GoDeli/features/checkout/aplication/checkout/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'payment_method_card.dart';

class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutBloc = context.read<CheckoutBloc>();
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                PaymentMethodCard(
                  method: goDeli.PaymentMethod(
                      id: 'stripe',
                      name: 'stripe',
                      state: 'active',
                      imageUrl: 'stripe'),
                  selectedMethod: state.selectedPaymentMethod,
                  onSelected: (selectedMethod) {
                    checkoutBloc.add(SelectPaymentMethod(selectedMethod));
                  },
                ),
                ...state.paymentMethods
                    .where((method) => method.state == 'active')
                    .map((method) {
                  return PaymentMethodCard(
                    method: method,
                    selectedMethod: state.selectedPaymentMethod,
                    onSelected: (selectedMethod) {
                      checkoutBloc.add(SelectPaymentMethod(selectedMethod));
                    },
                  );
                })
              ],
            ),
            if (state.selectedPaymentMethod?.name == 'stripe')
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      builder: (context) => const AddCardModal(),
                    );
                  },
                  child: const Text("Añadir Tarjeta"),
                ),
              )
          ],
        );
      },
    );
  }
}

class AddCardModal extends StatelessWidget {
  const AddCardModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Ajuste para el teclado
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add your payment information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CardField(
                onCardChanged: (cardDetails) {
                  // Manejar cambios en los datos de la tarjeta
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Country or region',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'ZIP Code',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Lógica para procesar el pago
                  Navigator.of(context).pop(); // Cierra el modal
                },
                child: const Text('Pay \$10.00'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}