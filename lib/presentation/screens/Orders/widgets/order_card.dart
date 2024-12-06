import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/features/orders/domain/orders.dart';

class OrderCard extends StatelessWidget {
  final OrderItem orderItem;

  const OrderCard({
    super.key,
    required this.orderItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date: ${orderItem.orderCreatedDate}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  'Total: \$${orderItem.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Order: ${orderItem.orderId}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(
                  Icons.shopping_bag,
                  color: Colors.red,
                ),
                SizedBox(width: 4),
                Text(
                  'Items',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildItemList(orderItem.products,
                orderItem.bundles), // Build the product and bundle list
            const SizedBox(height: 8),
            Text(
              'Status: ${orderItem.orderState}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: orderItem.orderState == 'ongoing'
                    ? Colors.green
                    : (orderItem.orderState == 'delivered'
                        ? Colors.black
                        : Colors.red),
              ),
            ),
            const SizedBox(height: 8),
            _buildActionButton(
                context, orderItem.orderState), // Build the action buttons
          ],
        ),
      ),
    );
  }

  Widget _buildItemList(List<ProductCart> products, List<BundleCart> bundles) {
    final List<Map<String, dynamic>> allItems = [
      ...products.map((product) =>
          {'name': product.product.name, 'quantity': product.quantity}),
      ...bundles.map(
          (bundle) => {'name': bundle.bundle.name, 'quantity': bundle.quantity})
    ];
    const int maxItemsToShow = 3;

    final List<Map<String, dynamic>> displayedItems =
        allItems.length <= maxItemsToShow
            ? allItems
            : allItems.sublist(0, maxItemsToShow);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: displayedItems.map((item) {
        final String name = item['name'];
        final int quantity = item['quantity'];
        return Text(
          '$name ($quantity)',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        );
      }).toList(),
    );
  }

  Widget _buildActionButton(BuildContext context, String orderState) {
    switch (orderState) {
      case 'ongoing':
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () => _cancelOrder(context),
              child: const Text('Cancel Order'),
            ),
            ElevatedButton(
              onPressed: () => _trackOrder(context),
              child: const Text('Track Order'),
            ),
          ],
        );
      case 'delivered':
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () => _reOrderItem(context),
              child: const Text('Reorder Item'),
            ),
            ElevatedButton(
              onPressed: () => _reportProblem(context),
              child: const Text('Report Your Problem'),
            ),
          ],
        );
      case 'cancelled':
        return Center(
          child: ElevatedButton(
            onPressed: () => _reportProblem(context),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 36), // Full width button
            ),
            child: const Text('Report Your Problem'),
          ),
        );
      default:
        return Container();
    }
  }

  void _cancelOrder(BuildContext context) {
    // Implement cancel order logic here
  }

  void _trackOrder(BuildContext context) {
    // Implement track order logic here
  }

  void _reOrderItem(BuildContext context) {
    // Implement reorder item logic here
  }

  void _reportProblem(BuildContext context) {
    // Implement report problem logic here
  }
}
