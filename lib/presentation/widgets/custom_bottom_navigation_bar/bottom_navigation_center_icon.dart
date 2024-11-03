import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationCenterIcon extends StatelessWidget {
  const BottomNavigationCenterIcon({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Center(
      child: SizedBox.fromSize(
        size: const Size(70, 70),
        child: FloatingActionButton(
          elevation: 8,
          backgroundColor: colors.primary,
          onPressed: (){
            context.push('/cart');
            print('clicked');
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.shopify, size: 40),
        ),
      ),
    );
  }
}