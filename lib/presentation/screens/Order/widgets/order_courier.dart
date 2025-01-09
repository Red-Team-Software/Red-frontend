import 'package:flutter/material.dart';
import 'package:GoDeli/features/order/domain/order.dart';

class OrderCourierCard extends StatelessWidget {
  final Courier courier;

  const OrderCourierCard({super.key, required this.courier});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.motorcycle, color: Colors.red),
            const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(courier.courierImage, width: 50, height: 50),
            ),
          ],
        ),
        title: const Text('Courier'),
        subtitle: Text(courier.courierName),
      ),
    );
  }
}
