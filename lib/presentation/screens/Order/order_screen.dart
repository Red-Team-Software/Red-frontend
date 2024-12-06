import 'package:GoDeli/features/order/aplication/Bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
          onPressed: () => context.push("/", extra: 3),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Order Summary',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is OrderLoaded) {
            final order = state.order;

            return Column(
              children: [
                OrderHeader(
                    orderSummary: order), // Encabezado con la info de la orden
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Items',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child:
                      OrderItemList(orderSummary: order), // Lista de productos
                ),
                OrderSummaryDetails(
                  orderSummary: order,
                ), // Subtotales y total
              ],
            );
          }

          return const Center(
            child: Text('Error loading order.'),
          );
        },
      ),
    );
  }
}
