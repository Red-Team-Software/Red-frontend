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
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.shopify,
              size: 40,
              color: Colors.white,
            ),
          ),
          onTap: () {
            context.push('/cart');
          },
        ),
      ),
    );
  }
}
