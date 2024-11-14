import 'package:GoDeli/features/products/domain/product.dart';
import 'package:flutter/material.dart';
import 'order_item_card.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';

class OrderItemList extends StatelessWidget {
  final List<ProductCart> items = [
    // Ejemplo de productos en el pedido
    ProductCart(
        product: Product(
            id: '1',
            name: 'Tuerca',
            price: 550,
            imageUrl: const [
              'https://europer.cl/wp-content/uploads/2020/07/a4-tuerca.jpg'
            ],
            description: 'Pack 2 Kg'),
        quantity: 1),
    ProductCart(
        product: Product(
            id: '7',
            name: 'Tuerca',
            price: 900,
            imageUrl: const [
              'https://europer.cl/wp-content/uploads/2020/07/a4-tuerca.jpg'
            ],
            description: 'Pack 2 Kg'),
        quantity: 1),
    ProductCart(
        product: Product(
            id: '7',
            name: 'Tuerca',
            price: 900,
            imageUrl: const [
              'https://europer.cl/wp-content/uploads/2020/07/a4-tuerca.jpg'
            ],
            description: 'Pack 2 Kg'),
        quantity: 1),
    ProductCart(
        product: Product(
            id: '7',
            name: 'Tuerca',
            price: 900,
            imageUrl: const [
              'https://europer.cl/wp-content/uploads/2020/07/a4-tuerca.jpg'
            ],
            description: 'Pack 2 Kg'),
        quantity: 1),
    ProductCart(
        product: Product(
            id: '2',
            name: 'Tuerca',
            price: 550,
            imageUrl: const [
              'https://europer.cl/wp-content/uploads/2020/07/a4-tuerca.jpg'
            ],
            description: 'Pack 2 Kg'),
        quantity: 1),
    ProductCart(
        product: Product(
            id: '3',
            name: 'Tuerca',
            price: 550,
            imageUrl: const [
              'https://europer.cl/wp-content/uploads/2020/07/a4-tuerca.jpg'
            ],
            description: 'Pack 2 Kg'),
        quantity: 1),
  ];

  OrderItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return OrderItemCard(item: items[index]);
      },
    );
  }
}
