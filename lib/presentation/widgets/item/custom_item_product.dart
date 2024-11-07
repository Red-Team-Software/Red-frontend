import 'package:flutter/material.dart';
import 'package:GoDeli/features/products/domain/product.dart';


class CustomItemProduct extends StatelessWidget {
  const CustomItemProduct({
    super.key,
    required this.current,
    required this.theme,
  });

  final Product current;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.grey[300],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width:80, height: 80, 
              child: ClipRRect(
              borderRadius: BorderRadius.circular(8.00),
              child: Image.network(current.imageUrl.isNotEmpty ? current.imageUrl[0] : '')),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(current.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                  Text(current.description, maxLines: 1, overflow: TextOverflow.clip,),
                ],
              ),),
            Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('\$${current.price}', style: const TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 4.00,),
                IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 24, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    padding: const EdgeInsets.all(0.5),
                    minimumSize: const Size(20, 20),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
