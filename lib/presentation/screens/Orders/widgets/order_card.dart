import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String orderState;
  final String orderId;
  final double totalAmount;
  final String orderCreatedDate;
  final List<dynamic> products;
  final List<dynamic> bundles;

  const OrderCard({
    super.key,
    required this.orderState,
    required this.orderId,
    required this.totalAmount,
    required this.orderCreatedDate,
    required this.products,
    required this.bundles,
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
                  'Date: $orderCreatedDate',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  'Total: \$${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Order: $orderId',
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
            _buildItemList(), // Build the product and bundle list
            const SizedBox(height: 8),
            Text(
              'Status: $orderState',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: orderState == 'ongoing'
                    ? Colors.green
                    : (orderState == 'delivered' ? Colors.black : Colors.red),
              ),
            ),
            const SizedBox(height: 8),
            _buildActionButton(context), // Build the action buttons
          ],
        ),
      ),
    );
  }

  // This method creates a list of product and bundle details based on the given constraints
  Widget _buildItemList() {
    final List<Map<String, dynamic>> allItems = [...products, ...bundles];
    const int maxItemsToShow = 3;

    // If total items are less than or equal to 3, show all; otherwise, limit to 3
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

  // This function conditionally renders the buttons based on order state
  Widget _buildActionButton(BuildContext context) {
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

  // Handle Cancel Order button click
  void _cancelOrder(BuildContext context) {
    // Implement cancel order logic here
  }

  // Handle Track Order button click
  void _trackOrder(BuildContext context) {
    // Implement track order logic here
  }

  // Handle Reorder Item button click
  void _reOrderItem(BuildContext context) {
    // Implement reorder item logic here
  }

  // Handle Report Problem button click
  void _reportProblem(BuildContext context) {
    // Implement report problem logic here
  }
}
