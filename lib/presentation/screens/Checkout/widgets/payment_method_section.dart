import 'package:flutter/material.dart';

class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
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
          children: paymentMethods
              .map((method) => CheckboxListTile(
                    title: Text(method),
                    value: true,
                    onChanged: (bool? value) {
                      // TODO: Actualizar selección de método de pago
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }
}
