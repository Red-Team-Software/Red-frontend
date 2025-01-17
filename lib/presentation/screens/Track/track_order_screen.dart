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
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/features/order/aplication/Bloc/order_bloc.dart';

class TrackOrderScreen extends StatefulWidget {
  static const String name = 'track_order_screen';

  final String orderId;

  const TrackOrderScreen({super.key, required this.orderId});

  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  late OrderBloc _orderBloc;

  @override
  void initState() {
    super.initState();
    _orderBloc = OrderBloc(orderRepository: getIt<IOrderRepository>());
    _fetchOrder();
  }

  @override
  void didUpdateWidget(covariant TrackOrderScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.orderId != widget.orderId) {
      _fetchOrder();
    }
  }

  void _fetchOrder() {
    print('TrackOrderScreen orderId: ${widget.orderId}');
    _orderBloc.add(FetchOrderById(orderId: widget.orderId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _orderBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Track Order'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _orderBloc.add(ClearOrderState()); // Clear the state
              context.push("/", extra: 3);
            },
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
                      deliveryLatitude: order.orderCourier?.location?.latitude,
                      deliveryLongitude:
                          order.orderCourier?.location?.longitude,
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

  @override
  void dispose() {
    _orderBloc.close();
    super.dispose();
  }
}
