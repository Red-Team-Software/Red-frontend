import 'package:GoDeli/features/orders/aplication/Bloc/orders_event.dart';
import 'package:GoDeli/features/orders/domain/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/features/orders/aplication/Bloc/orders_bloc.dart';
import 'package:GoDeli/features/orders/aplication/Bloc/orders_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'widgets/order_card.dart';

class OrderListScreen extends StatefulWidget {
  static const String name = 'order_list_screen';

  const OrderListScreen({super.key});

  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  String selectedTab = 'Active';

  @override
  void initState() {
    super.initState();
    context.read<OrdersBloc>().add(const OrdersLoaded());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;
    final state = context.watch<OrdersBloc>().state;

    if (state is OrdersLoadInProgress) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is OrdersLoadSuccess) {
      final orders = state.orders.orders;

      // Filter orders based on the selected tab
      List<OrderItem> filteredOrders = orders.where((order) {
        if (selectedTab == 'Active') {
          return order.orderState == 'ongoing';
        } else if (selectedTab == 'Past') {
          return order.orderState == 'delivered' ||
              order.orderState == 'cancelled';
        }
        return false;
      }).toList();

      // Count the orders for each tab
      int activeCount =
          orders.where((order) => order.orderState == 'ongoing').length;
      int pastCount = orders
          .where((order) =>
              order.orderState == 'delivered' ||
              order.orderState == 'cancelled')
          .length;

      return Scaffold(
        appBar: AppBar(
          title: Text('Order List', style: textStyles.displayLarge),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.push("/", extra: 0),
          ),
        ),
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
                            ? colors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Active Orders ($activeCount)',
                        style: textStyles.displaySmall?.copyWith(
                          color: selectedTab == 'Active'
                              ? Colors.white
                              : Colors.grey,
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
                            ? colors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Past Orders ($pastCount)',
                        style: textStyles.displaySmall?.copyWith(
                          color: selectedTab == 'Past'
                              ? Colors.white
                              : Colors.grey,
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
              child: filteredOrders.isEmpty
                  ? Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Centrar verticalmente
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Centrar horizontalmente
                      children: [
                          SvgPicture.asset(
                            'images/empty_bag.svg',
                            height: 100,
                            color: colors.primary,
                          ),
                          const SizedBox(height: 16),
                          Center(
                              child: Text(
                            'Aún no dispone de alguna orden',
                            style: textStyles.displaySmall?.copyWith(
                              color: colors.primary,
                            ),
                          )),
                        ])
                  : ListView.builder(
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        final order = filteredOrders[index];
                        return GestureDetector(
                          onTap: () {
                            context.push("/order/${order.orderId}");
                          },
                          child: OrderCard(orderItem: order),
                        );
                      },
                    ),
            ),
          ],
        ),
      );
    } else if (state is OrdersLoadFailure) {
      return ErrorView(
        errorMessage: 'Failed to load orders: ${state.error}',
        onRetry: () {
          context.read<OrdersBloc>().add(const OrdersLoaded());
        },
      );
    } else {
      return Container();
    }
  }
}

// New ErrorView widget
class ErrorView extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const ErrorView({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Oops!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
