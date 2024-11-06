import 'package:GoDeli/features/products/domain/product.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, 
    required this.current,
  });

  final Product current;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
        color: theme.brightness == Brightness.dark ? Colors.grey[800] : Colors.white,
        elevation: 8,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
            child: SizedBox(
              height: 110,
              width: 200,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                      current.imageUrl.isNotEmpty ? current.imageUrl[0] : '')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1, left: 20, right: 20),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  current.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 20),
                ),
                const Icon(Icons.fireplace)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1, left: 20, right: 20),
            child: Text(
              current.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 12,
                  color: theme.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Flex(
              direction: Axis.horizontal, 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    '\$ ${current.price}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: theme.brightness ==Brightness.dark? Colors.white:Colors.black),
                ),
                IconButton.filled(
                  onPressed: () {},
                  icon: Icon(Icons.add, size: 20, color: theme.colorScheme.primary),
                  style: IconButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    padding: const EdgeInsets.all(0.5),
                    minimumSize: const Size(16, 20), // Tamaño del cuadrado pequeño
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6), // Bordes redondeados
                    ),
                  ),
                )
              ],
            ),
          )

        ]));
  }
}