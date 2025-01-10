import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_bloc.dart';
import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_event.dart';
import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_state.dart';
import 'package:GoDeli/features/payment-method/domain/payment-method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              children: state.paymentMethods
                  .where((method) => method.state == 'active')
                  .map((method) {
                return PaymentMethodCard(
                  method: method,
                  selectedMethod: state.selectedPaymentMethod,
                  onSelected: (selectedMethod) {
                    checkoutBloc.add(SelectPaymentMethod(selectedMethod));
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
