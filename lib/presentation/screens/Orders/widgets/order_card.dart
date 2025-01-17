import 'package:GoDeli/common/Date/date.dart';
import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:GoDeli/features/orders/aplication/Bloc/orders_bloc.dart';
import 'package:GoDeli/features/orders/aplication/Bloc/orders_event.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/features/orders/domain/orders.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrderCard extends StatelessWidget {
  final OrderItem orderItem;

  const OrderCard({
    super.key,
    required this.orderItem,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final language =  context.watch<LanguagesCubit>().state.selected.language;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ TranslationWidget(
                message: 'Order: ${orderItem.orderId.substring(orderItem.orderId.length - 6)}',
              toLanguage: language,
              builder: (translated) => Text(
                  translated,
                  style: textStyles.bodyLarge?.copyWith(
                    color: Colors.grey
                  )
              ), 
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date: ${DateMapper.isoToDDMMYY(orderItem.orderCreatedDate)}',
                  style: textStyles.displaySmall,
                ),
                Text(
                  'Time: ${DateMapper.isoToHHMMAM(orderItem.orderCreatedDate)}',
                  style: textStyles.displaySmall,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Total: \$${orderItem.totalAmount.toStringAsFixed(2)}',
              style:textStyles.displaySmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.shopping_bag,
                  color: colors.primary,
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Items',
                    style: textStyles.displaySmall?.copyWith(
                      color: colors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildItemList(orderItem.summaryOrder),
            const SizedBox(height: 8),
            Text(
              'Status: ${orderItem.orderState}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: orderItem.orderState == 'ongoing' || orderItem.orderState ==  'CREATED'
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

  Widget _buildItemList(String itemDescription) {
    print("Item Description: $itemDescription");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          itemDescription,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, String orderState) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    switch (orderState) {
      case "delivering":
      case 'ongoing' || 'CREATED':
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () => _cancelOrder(context),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
              )),
              child: Text('Cancel Order',
              style: textStyles.bodyLarge?.copyWith(
                color: colors.primary
              ),
            ),),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
              )),
              onPressed: () => _trackOrder(context),
              child: Text('Track Order',
              style: textStyles.bodyLarge?.copyWith(
                color: colors.primary
              ),)
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
    print("Order cancel button pressed");
    // Emit the OrderCancelled event
    context.read<OrdersBloc>().add(OrderCancelled(orderId: orderItem.orderId));
  }

  void _trackOrder(BuildContext context) {
    context.go('/track_order/${orderItem.orderId}');
  }

  void _reOrderItem(BuildContext context) {
    // Implement reorder item logic here
  }

  void _reportOrder(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      isScrollControlled: true,
      builder: (context) {
        String reportDescription = '';
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Report Order Issue',
                        style: textStyles.bodyLarge?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            reportDescription = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: reportDescription.isNotEmpty
                            ? () {
                                context.read<OrdersBloc>().add(OrderReported(
                                    orderId: orderItem.orderId,
                                    description: reportDescription));
                                Navigator.pop(context);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          minimumSize: const Size.fromHeight(48),
                        ),
                        child: Text(
                          'Report',
                          style:textStyles.bodyLarge?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                        ) ,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _reportProblem(BuildContext context) {
    _reportOrder(context);
  }
}
