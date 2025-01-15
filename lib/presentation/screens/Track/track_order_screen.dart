import 'package:GoDeli/presentation/core/router/app_router.dart';
import 'package:GoDeli/presentation/screens/Order/widgets/order_bundle_card.dart';
import 'package:GoDeli/presentation/screens/Order/widgets/order_product_card.dart';
import 'package:GoDeli/presentation/screens/Track/widgets/order_info_widget.dart';
import 'package:GoDeli/presentation/screens/Track/widgets/order_items_widget.dart';
import 'package:GoDeli/presentation/screens/Track/widgets/order_status_widget.dart';
import 'package:GoDeli/presentation/screens/Track/widgets/order_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/features/orders/domain/orders.dart';
import 'package:go_router/go_router.dart';

class TrackOrderScreen extends StatelessWidget {
  static const String name = 'track_order_screen';

  final OrderItem orderItem;

  const TrackOrderScreen({super.key, required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.push("/", extra: 3),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderStatusWidget(orderId: orderItem.orderId),
            const SizedBox(height: 16),
            OrderInfoWidget(orderId: orderItem.orderId),
            const SizedBox(height: 16),
            OrderMapWidget(
              userLatitude: orderItem.orderDirection.latitude,
              userLongitude: orderItem.orderDirection.longitude,
              deliveryLatitude: 10.511052,
              deliveryLongitude: -66.906131,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  if (orderItem.products.isNotEmpty)
                    ...orderItem.products.map(
                      (product) => OrderProductCard(item: product),
                    ),
                  if (orderItem.bundles.isNotEmpty)
                    ...orderItem.bundles.map(
                      (bundle) => OrderBundleCard(item: bundle),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
