import 'package:flutter/material.dart';

class OrderInfoWidget extends StatelessWidget {
  final String orderId;

  const OrderInfoWidget({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    // Aquí podrías obtener la información de la orden desde el backend
    // Usaré valores ficticios para ilustrar el ejemplo.
    String orderCreatedDate = "2024-12-06";
    String orderReceivedDate = "2024-12-08";
    double totalAmount = 61.27;

    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: $orderId', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Created Date: $orderCreatedDate',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Estimated Delivery: $orderReceivedDate',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Total Amount: \$$totalAmount',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
