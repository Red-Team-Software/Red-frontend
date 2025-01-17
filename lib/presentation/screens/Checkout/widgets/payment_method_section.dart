import 'package:GoDeli/features/payment-method/domain/payment-method.dart'
    as goDeli;
import 'package:GoDeli/features/checkout/aplication/checkout/checkout_bloc.dart';
import 'package:GoDeli/features/checkout/aplication/checkout/checkout_event.dart';
import 'package:GoDeli/features/checkout/aplication/checkout/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:GoDeli/presentation/screens/Checkout/cards_screen.dart';
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
                    if (selectedMethod.name == 'stripe') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CardsScreen()),
                      );
                    }
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
          ],
        );
      },
    );
  }
}

// class AddCardModal extends StatelessWidget {
//   const AddCardModal({super.key});

//   Future<void> _saveCard(
//       BuildContext context, CardFieldInputDetails? cardDetails) async {
//     if (cardDetails == null || !cardDetails.complete) {
//       print("Detalles de la tarjeta incompletos");
//     }

//     print("guardando tarjeta");
//     try {
//       final paymentMethod = await Stripe.instance.createPaymentMethod(
//         params: const PaymentMethodParams.card(
//           paymentMethodData: PaymentMethodData(
//             billingDetails: BillingDetails(name: 'Nombre del titular'),
//           ),
//         ),
//       );

//       final cardId = paymentMethod.id;
//       print('Tarjeta creada con ID: $cardId');
//       // Navigator.of(context).pop(); // Cierra el modal
//     } catch (e) {
//       print('Error al guardar la tarjeta: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     CardFieldInputDetails? cardDetails;

//     return Padding(
//       padding: EdgeInsets.only(
//         bottom:
//             MediaQuery.of(context).viewInsets.bottom, // Ajuste para el teclado
//       ),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Add your payment information',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               CardField(
//                 onCardChanged: (card) {
//                   cardDetails = card;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Country or region',
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'ZIP Code',
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () => _saveCard(context, cardDetails),
//                   child: const Text('Pay \$10.00'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
