import 'package:flutter/material.dart';

class OrderStatusWidget extends StatelessWidget {
  final String orderId;

  const OrderStatusWidget({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    // Aquí podrías hacer la llamada al backend para obtener el estado de la orden
    // Usaré un valor ficticio para ilustrar el ejemplo.
    String orderStatus = "Ongoing"; // Esto sería dinámico en tu implementación.

    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 8),
            Text(
              'Order Status: $orderStatus',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
