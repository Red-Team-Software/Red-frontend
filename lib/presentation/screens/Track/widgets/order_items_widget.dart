import 'package:flutter/material.dart';

class OrderItemsWidget extends StatelessWidget {
  final String orderId;

  const OrderItemsWidget({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    // Aquí podrías obtener los artículos de la orden desde el backend
    // Usaré una lista ficticia para ilustrar el ejemplo.
    List<Map<String, dynamic>> orderItems = [
      {"name": "Coca-Cola", "quantity": 2},
      {"name": "Pepsi", "quantity": 1},
    ];

    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Order Items',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              itemCount: orderItems.length,
              itemBuilder: (context, index) {
                var item = orderItems[index];
                return Row(
                  children: [
                    const Icon(Icons.shopping_basket, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text('${item['name']} - Quantity: ${item['quantity']}'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
