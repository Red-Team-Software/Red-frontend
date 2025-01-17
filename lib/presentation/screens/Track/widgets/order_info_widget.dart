import 'package:flutter/material.dart';

class OrderInfoWidget extends StatelessWidget {
  final String orderId;
  final String orderCreatedDate;
  final double totalAmount;

  const OrderInfoWidget({
    super.key,
    required this.orderId,
    required this.orderCreatedDate,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
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
            Text('Total Amount: \$$totalAmount',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
