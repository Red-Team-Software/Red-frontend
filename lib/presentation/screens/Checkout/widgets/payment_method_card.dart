import 'package:flutter/material.dart';
import 'package:GoDeli/features/payment-method/domain/payment-method.dart';

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethod method;
  final PaymentMethod? selectedMethod;
  final ValueChanged<PaymentMethod> onSelected;

  const PaymentMethodCard({
    super.key,
    required this.method,
    required this.selectedMethod,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = method.name == selectedMethod?.name;
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => onSelected(method),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: method.imageUrl=='stripe' ?  Image.asset(
                  'images/stripe_logo.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ) : Image.network(
                  method.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      method.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: colors.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
