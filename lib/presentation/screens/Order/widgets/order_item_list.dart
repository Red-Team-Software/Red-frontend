import 'package:GoDeli/features/order/domain/order.dart';
import 'package:GoDeli/presentation/screens/Order/widgets/order_bundle_card.dart';
import 'package:flutter/material.dart';
import 'order_product_card.dart';

class OrderItemList extends StatelessWidget {
  final Order orderSummary;

  const OrderItemList({super.key, required this.orderSummary});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Productos
          if (orderSummary.products.isNotEmpty)
            ...orderSummary.products.map(
              (product) => OrderProductCard(item: product),
            ),
          // Bundles
          if (orderSummary.bundles.isNotEmpty)
            ...orderSummary.bundles.map(
              (bundle) => OrderBundleCard(item: bundle),
            ),
        ],
      ),
    );
  }
}
