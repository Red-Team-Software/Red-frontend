import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/order/domain/repositories/order_repository.dart';
import 'package:GoDeli/presentation/screens/Order/widgets/order_bundle_card.dart';
import 'package:GoDeli/presentation/screens/Order/widgets/order_product_card.dart';
import 'package:GoDeli/presentation/screens/Track/widgets/order_info_widget.dart';
import 'package:GoDeli/presentation/screens/Track/widgets/order_status_widget.dart';
import 'package:GoDeli/presentation/screens/Track/widgets/order_map_widget.dart';
import 'package:GoDeli/presentation/widgets/courier/order_courier.dart';
import 'package:GoDeli/presentation/widgets/courier/searching_courier.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/features/orders/domain/orders.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/features/order/aplication/Bloc/order_bloc.dart';

class TrackOrderScreen extends StatelessWidget {
  static const String name = 'track_order_screen';

  final OrderItem orderItem;

  const TrackOrderScreen({super.key, required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(orderRepository: getIt<IOrderRepository>())
        ..add(FetchOrderById(orderId: orderItem.orderId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Track Order'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.push("/", extra: 3),
          ),
        ),
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderLoaded) {
              final order = state.order;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderStatusWidget(orderId: order.id),
                    const SizedBox(height: 16),
                    OrderInfoWidget(
                      orderId: order.id,
                      orderCreatedDate: order.orderCreatedDate,
                      totalAmount: order.totalAmount,
                    ),
                    const SizedBox(height: 16),
                    order.orderCourier != null
                        ? OrderCourierCard(courier: order.orderCourier!)
                        : const SearchingCourier(),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        children: [
                          if (order.products.isNotEmpty)
                            ...order.products.map(
                              (product) => OrderProductCard(item: product),
                            ),
                          if (order.bundles.isNotEmpty)
                            ...order.bundles.map(
                              (bundle) => OrderBundleCard(item: bundle),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    OrderMapWidget(
                      userLatitude: order.orderDirection.latitude,
                      userLongitude: order.orderDirection.longitude,
                    ),
                  ],
                ),
              );
            } else if (state is OrderError) {
              return Center(
                  child: Text('Failed to load order: ${state.message}'));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
