import 'package:flutter/material.dart';
import 'widgets/order_card.dart';

class OrderListScreen extends StatefulWidget {
  static const String name = 'order_list_screen';
  final List<Map<String, dynamic>> orders = [
    {
      "orderId": "09268406-3bd0-4905-9fba-e26a1c695a6b",
      "orderState": "ongoing",
      "orderCreatedDate": "2024-12-06",
      "totalAmount": 61.27,
      "products": [
        {"name": "Coca-Cola", "quantity": 2},
        {"name": "Pepsi", "quantity": 1}
      ],
      "bundles": [
        {"name": "Bundle 1", "quantity": 1}
      ]
    },
    {
      "orderId": "0dbd42dc-0bed-446b-ac90-68e60fc43a96",
      "orderState": "delivered",
      "orderCreatedDate": "2024-12-05",
      "totalAmount": 25.99,
      "products": [
        {"name": "Burger", "quantity": 2},
      ],
      "bundles": []
    },
    {
      "orderId": "279ebb28-9344-4234-9690-8d82057a547f",
      "orderState": "cancelled",
      "orderCreatedDate": "2024-12-04",
      "totalAmount": 12.50,
      "products": [],
      "bundles": [
        {"name": "Combo 1", "quantity": 2},
        {"name": "Combo 2", "quantity": 1}
      ]
    },
  ];

  OrderListScreen({super.key});

  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  String selectedTab = 'Active';

  @override
  Widget build(BuildContext context) {
    // Filter orders based on the selected tab
    List<Map<String, dynamic>> filteredOrders = widget.orders.where((order) {
      if (selectedTab == 'Active') {
        return order['orderState'] == 'ongoing';
      } else if (selectedTab == 'Past') {
        return order['orderState'] == 'delivered' ||
            order['orderState'] == 'cancelled';
      }
      return false;
    }).toList();

    // Count the orders for each tab
    int activeCount =
        widget.orders.where((order) => order['orderState'] == 'ongoing').length;
    int pastCount = widget.orders
        .where((order) =>
            order['orderState'] == 'delivered' ||
            order['orderState'] == 'cancelled')
        .length;

    return Scaffold(
      appBar: AppBar(title: const Text('Order List')),
      body: Column(
        children: [
          // Centered Tabs to switch between Active and Past Orders
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = 'Active';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: selectedTab == 'Active'
                          ? Colors.red
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Active Orders ($activeCount)',
                      style: TextStyle(
                        color: selectedTab == 'Active'
                            ? Colors.white
                            : Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = 'Past';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: selectedTab == 'Past'
                          ? Colors.red
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Past Orders ($pastCount)',
                      style: TextStyle(
                        color:
                            selectedTab == 'Past' ? Colors.white : Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),

          // ListView of filtered orders
          Expanded(
            child: ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                final order = filteredOrders[index];
                return OrderCard(
                  orderState: order['orderState'],
                  orderId: order['orderId'],
                  totalAmount: order['totalAmount'],
                  orderCreatedDate: order['orderCreatedDate'],
                  products: order['products'],
                  bundles: order['bundles'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
