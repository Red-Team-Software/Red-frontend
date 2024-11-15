import 'package:flutter/material.dart';
import 'widgets/order_header.dart';
import 'widgets/order_item_list.dart';
import 'widgets/order_summary_details.dart';

class OrderSummaryScreen extends StatelessWidget {
  static const String name = 'order_summary_screen';
  final String idOrder;

  const OrderSummaryScreen({super.key, required this.idOrder});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Order Summary',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const OrderHeader(), // Encabezado con el número de orden, estado, etc.
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Items',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: OrderItemList(), // Lista de productos
          ),
          const OrderSummaryDetails(), // Subtotales y total
        ],
      ),
    );
  }
}
