import 'package:GoDeli/features/orders/aplication/Bloc/orders_event.dart';
import 'package:GoDeli/features/orders/domain/orders.dart';
import 'package:GoDeli/presentation/widgets/snackbar/custom_snackbar.dart';
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
      final activeOrders = state.activeOrders.orders;
      final pastOrders = state.pastOrders.orders;

      // Show snackbar if there is an order report error
      if (state.orderReportError != null &&
          state.orderReportError!.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomSnackBar.show(
            context,
            type: SnackBarType.error,
            title: 'Report error',
            message: state.orderReportError!,
          );
          context.read<OrdersBloc>().add(ClearOrderReportErrorEvent());
        });
      }

      // Count the orders for each tab
      int activeCount = activeOrders.length;
      int pastCount = pastOrders.length;

      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Order List', style: textStyles.displayLarge),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.push("/", extra: 0),
            ),
            bottom: TabBar(
              indicator: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: colors.primary,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Active Orders ($activeCount)',
                        style: TextStyle(fontSize: textStyles.displaySmall?.fontSize, 
                        fontWeight: textStyles.displaySmall?.fontWeight,)),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Past Orders ($pastCount)',
                        style: TextStyle(fontSize: textStyles.displaySmall?.fontSize, 
                        fontWeight: textStyles.displaySmall?.fontWeight,)),
                  ),
                ),
              ],
              onTap: (index) {
                setState(() {
                  selectedTab = index == 0 ? 'Active' : 'Past';
                });
              },
            ),
          ),
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            children: [
              _buildOrderList(activeOrders, colors, textStyles),
              _buildOrderList(pastOrders, colors, textStyles),
            ],
          ),
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

  Widget _buildOrderList(
      List<OrderItem> orders, ColorScheme colors, TextTheme textStyles) {
    return orders.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
            ],
          )
        : ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return GestureDetector(
                onTap: () {
                  context.push("/order/${order.orderId}");
                },
                child: OrderCard(orderItem: order),
              );
            },
          );
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
