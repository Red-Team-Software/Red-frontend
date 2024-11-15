import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:flutter/material.dart';
import 'widgets/order_header.dart';
import 'widgets/order_item_list.dart';
import 'widgets/order_summary_details.dart';

class OrderPayment {
  final String paymentMethod;
  final String currency;
  final double amount;

  OrderPayment({
    required this.paymentMethod,
    required this.currency,
    required this.amount,
  });
}

class OrderDirection {
  final num latitude;
  final num longitude;

  OrderDirection({
    required this.latitude,
    required this.longitude,
  });
}

class OrderSummary {
  final String id;
  final String orderState;
  final double subtotal;
  final List<ProductCart> products;
  final List<BundleCart> bundles;
  final String orderCreatedDate;
  final String? orderRecievdDate;
  final num totalAmount;
  final String currency;
  final OrderPayment orderPayment;
  final OrderDirection orderDirection;

  OrderSummary({
    required this.id,
    required this.orderState,
    required this.subtotal,
    required this.products,
    required this.bundles,
    required this.orderCreatedDate,
    this.orderRecievdDate,
    required this.totalAmount,
    required this.currency,
    required this.orderPayment,
    required this.orderDirection,
  });
}

class OrderSummaryScreen extends StatelessWidget {
  static const String name = 'order_summary_screen';
  final String idOrder;

  OrderSummaryScreen({super.key, required this.idOrder});

  OrderSummary orderSummary = OrderSummary(
    id: "6918864e-7fe6-4f71-a75a-5ff5aa851c13",
    orderState: "ongoing",
    subtotal: 126.0,
    products: [
      ProductCart(
          product: Product(
            id: "1060b14e-ecfa-4379-86d4-e1245ecd5501",
            name: "Arroz frito", // No se proporciona el nombre en los datos
            description:
                "El arroz frito es una deliciosa mezcla de sabores y texturas que conquista paladares en todo el mundo. Este plato combina arroz cocido y enfriado con una variedad de ingredientes frescos y coloridos, salteados a la perfección en un wok caliente.", // No se proporciona descripción en los datos
            price: 5, // No se proporciona el precio en los datos
            imageUrl: [
              "http://res.cloudinary.com/dqxreuowl/image/upload/v1731570733/c680bb81-4897-467f-a432-4ede8ac184bb.jpg",
              "http://res.cloudinary.com/dqxreuowl/image/upload/v1731570734/111df0eb-4d84-4d56-8120-b9d77ae2368a.jpg"
            ], // No se proporcionan URLs de imágenes
          ),
          quantity: 5)
    ],
    bundles: [
      BundleCart(
        bundle: Bundle(
          id: "b1",
          name: "Combo de arroz frito",
          description:
              "¡Disfruta de un delicioso combo de arroz frito! Incluye 5 porciones de arroz frito, 5 rollos de sushi y 5 bebidas.",
          price: 16,
          currency: 'usd',
          imageUrl: [
            "http://res.cloudinary.com/dqxreuowl/image/upload/v1731570733/c680bb81-4897-467f-a432-4ede8ac184bb.jpg",
            "http://res.cloudinary.com/dqxreuowl/image/upload/v1731570734/111df0eb-4d84-4d56-8120-b9d77ae2368a.jpg"
          ],
        ),
        quantity: 1,
      )
    ],
    orderCreatedDate: "2024-11-14T20:12:44.595Z",
    totalAmount: 126,
    currency: "usd",
    orderPayment: OrderPayment(
      paymentMethod: "card",
      currency: "usd",
      amount: 126.0,
    ),
    orderDirection: OrderDirection(
      latitude: 10.4399,
      longitude: -66.89275,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Order Summary',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          OrderHeader(
              orderSummary:
                  orderSummary), // Encabezado con el número de orden, estado, etc.
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Items',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: OrderItemList(orderSummary: orderSummary,), // Lista de productos
          ),
          OrderSummaryDetails(
            orderSummary: orderSummary,
          ), // Subtotales y total
        ],
      ),
    );
  }
}
