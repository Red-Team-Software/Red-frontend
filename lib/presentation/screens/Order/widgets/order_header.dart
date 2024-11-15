import 'package:GoDeli/presentation/screens/Order/order_screen.dart';
import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {
  final OrderSummary orderSummary;

  const OrderHeader({super.key, required this.orderSummary});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // Borde redondeado
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Order #${orderSummary.id}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow
                      .ellipsis, // Para truncar el texto si es demasiado largo
                  softWrap: true,
                ),
              ),
              const SizedBox(width: 8), // Espacio entre los textos
              Flexible(
                child: Text(
                  orderSummary.orderState,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0E650E),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow
                      .ellipsis, // Para truncar el texto si es necesario
                  softWrap: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Delivery ${orderSummary.orderCreatedDate}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Payment method',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            orderSummary.orderPayment.paymentMethod,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const Divider(height: 16, color: Colors.grey),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: colors.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Lat: ${orderSummary.orderDirection.latitude.toString()} | Lon: ${orderSummary.orderDirection.longitude.toString()}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
          Row(children: [
            Icon(
              Icons.lock_clock,
              color: colors.primary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Lat: ${orderSummary.orderDirection.latitude.toString()} | Lon: ${orderSummary.orderDirection.longitude.toString()}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
