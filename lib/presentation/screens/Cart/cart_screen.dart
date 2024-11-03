import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {

  static const String name = 'cart_screen';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=> context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Cart'),
        actions: <Widget>[
          Text('4 items', style: TextStyle(color: colors.primary , fontSize: 12, fontWeight: FontWeight.w700),),
          const SizedBox(width: 8,)
        ],
      ),

      body: const Center(
        child: Text('Cart Screen'),
      ),
    );
  }
}