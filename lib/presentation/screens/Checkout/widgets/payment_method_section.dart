import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_bloc.dart';
import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_event.dart';
import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutBloc = context.read<CheckoutBloc>();
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        final paymentMethods = [
          'cash on delivery',
          'Pago movil',
          'PayPal',
          'Zelle'
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              children: paymentMethods.map((method) {
                return RadioListTile<String>(
                  title: Text(method),
                  value: method,
                  groupValue: state.selectedPaymentMethod,
                  onChanged: (value) {
                    checkoutBloc.add(SelectPaymentMethod(value!));
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
